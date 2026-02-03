import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/booking.dart';
import '../models/menu_item.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection reference
  CollectionReference get bookingsCollection =>
      _firestore.collection('bookings');

  CollectionReference get menuItemsCollection =>
      _firestore.collection('menu_items');

  // Create a new booking
  Future<String> createBooking(Booking booking) async {
    try {
      DocumentReference docRef = await bookingsCollection.add(booking.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  // Get a single booking by ID
  Future<Booking?> getBooking(String bookingId) async {
    try {
      DocumentSnapshot doc = await bookingsCollection.doc(bookingId).get();
      if (doc.exists) {
        return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get booking: $e');
    }
  }

  // Get all bookings (for admin)
  Stream<List<Booking>> getAllBookings() {
    return bookingsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        });
  }

  // Get bookings by status
  Stream<List<Booking>> getBookingsByStatus(String status) {
    return bookingsCollection
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        });
  }

  // Get bookings by phone number (for customer to view their bookings)
  Stream<List<Booking>> getBookingsByPhone(String phoneNumber) {
    return bookingsCollection
        .where('customerPhone', isEqualTo: phoneNumber)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        });
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await bookingsCollection.doc(bookingId).update({'status': status});
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }

  // Update entire booking
  Future<void> updateBooking(String bookingId, Booking booking) async {
    try {
      await bookingsCollection.doc(bookingId).update(booking.toMap());
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  // Delete booking
  Future<void> deleteBooking(String bookingId) async {
    try {
      await bookingsCollection.doc(bookingId).delete();
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  // Get bookings for a specific date range
  Future<List<Booking>> getBookingsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      QuerySnapshot snapshot = await bookingsCollection
          .where(
            'eventDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .where('eventDate', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('eventDate')
          .get();

      return snapshot.docs.map((doc) {
        return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get bookings by date range: $e');
    }
  }

  // Get booking statistics
  Future<Map<String, int>> getBookingStats() async {
    try {
      QuerySnapshot allBookings = await bookingsCollection.get();
      QuerySnapshot pendingBookings = await bookingsCollection
          .where('status', isEqualTo: 'pending')
          .get();
      QuerySnapshot confirmedBookings = await bookingsCollection
          .where('status', isEqualTo: 'confirmed')
          .get();
      QuerySnapshot cancelledBookings = await bookingsCollection
          .where('status', isEqualTo: 'cancelled')
          .get();

      return {
        'total': allBookings.docs.length,
        'pending': pendingBookings.docs.length,
        'confirmed': confirmedBookings.docs.length,
        'cancelled': cancelledBookings.docs.length,
      };
    } catch (e) {
      throw Exception('Failed to get booking stats: $e');
    }
  }

  // Search bookings by customer name or phone
  Future<List<Booking>> searchBookings(String query) async {
    try {
      // Note: Firestore doesn't support full-text search natively
      // This is a simple implementation that searches by exact phone match
      // For better search, consider using Algolia or similar service
      QuerySnapshot snapshot = await bookingsCollection
          .where('customerPhone', isEqualTo: query)
          .get();

      if (snapshot.docs.isEmpty) {
        // Try searching by name
        snapshot = await bookingsCollection
            .where('customerName', isEqualTo: query)
            .get();
      }

      return snapshot.docs.map((doc) {
        return Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to search bookings: $e');
    }
  }

  // MARK: - Storage
  Future<String> uploadImage(File file, String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // MARK: - Menu Items

  // Create a new menu item
  Future<String> addMenuItem(MenuItem item) async {
    try {
      DocumentReference docRef = await menuItemsCollection.add(item.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add menu item: $e');
    }
  }

  // Update a menu item
  Future<void> updateMenuItem(MenuItem item) async {
    try {
      await menuItemsCollection.doc(item.id).update(item.toMap());
    } catch (e) {
      throw Exception('Failed to update menu item: $e');
    }
  }

  // Delete a menu item
  Future<void> deleteMenuItem(String id) async {
    try {
      await menuItemsCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete menu item: $e');
    }
  }

  // Get all menu items
  Stream<List<MenuItem>> getMenuItems() {
    return menuItemsCollection.orderBy('nameEn').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MenuItem.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Get menu items by category
  Stream<List<MenuItem>> getMenuItemsByCategory(String category) {
    return menuItemsCollection
        .where('category', isEqualTo: category)
        .orderBy('nameEn')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MenuItem.fromMap(doc.id, doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }
}
