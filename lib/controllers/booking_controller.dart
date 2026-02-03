import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import '../models/booking.dart';
import '../services/firebase_service.dart';
import 'auth_controller.dart';

class BookingController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final AuthController _authController = Get.find<AuthController>();

  // Reactive variables
  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Booking?> currentBooking = Rx<Booking?>(null);

  // Admin: All bookings list
  final RxList<Booking> allBookings = <Booking>[].obs;
  final RxList<Booking> filteredBookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Only bind if user is admin?
    // Ideally we should check role, but for now we bind it.
    // Or we can lazy load it.
    // Let's lazy load it in a separate method or init.
  }

  void initAdmin() {
    allBookings.bindStream(_firebaseService.getAllBookings());
    ever(allBookings, (_) {
      filteredBookings.value = allBookings;
    });
  }

  void filterBookings(String status) {
    if (status == 'All Bookings') {
      filteredBookings.value = allBookings;
    } else {
      filteredBookings.value = allBookings
          .where((b) => b.status.toLowerCase() == status.toLowerCase())
          .toList();
    }
  }

  // Submit booking
  Future<bool> submitBooking({
    required String eventType,
    required String serviceType,
    required Map<String, int> selectedMenuItems,
    required int guestCount,
    required DateTime eventDate,
    required String serviceTime,
    required String venueAddress,
  }) async {
    try {
      isSubmitting.value = true;
      errorMessage.value = '';

      // Check if Firebase is initialized
      try {
        Firebase.app();
      } catch (e) {
        throw Exception('Firebase is not initialized. Please restart the app.');
      }

      // Generate unique booking ID
      const uuid = Uuid();
      final bookingId = uuid.v4();

      // Create booking object with user info
      final booking = Booking(
        id: bookingId,
        eventType: eventType,
        serviceType: serviceType,
        selectedMenuItems: selectedMenuItems,
        guestCount: guestCount,
        eventDate: eventDate,
        serviceTime: serviceTime,
        venueAddress: venueAddress,
        createdAt: DateTime.now(),
        status: 'pending',
        customerName: _authController.userName,
        customerEmail: _authController.userEmail,
      );

      print('📝 Creating booking: $bookingId for ${_authController.userName}');

      // Save to Firebase
      await _firebaseService.createBooking(booking);

      print('✅ Booking saved successfully!');

      // Store current booking
      currentBooking.value = booking;

      // Show success message
      Get.snackbar(
        'Success',
        'Booking saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      return true;
    } catch (e) {
      print('❌ Error saving booking: $e');
      errorMessage.value = e.toString();

      // Show error message
      Get.snackbar(
        'Error',
        'Error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );

      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  // Get user's bookings
  Stream<List<Booking>> getUserBookings() {
    if (_authController.userEmail != null) {
      return _firebaseService.getBookingsByPhone(_authController.userEmail!);
    }
    return Stream.value([]);
  }

  void clearCurrentBooking() {
    currentBooking.value = null;
  }

  Future<void> updateBookingStatus(String id, String status) async {
    try {
      await _firebaseService.updateBookingStatus(id, status);
      Get.snackbar('Success', 'Booking status updated to $status');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update booking status: $e');
    }
  }
}
