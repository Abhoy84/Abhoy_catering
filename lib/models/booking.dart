import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String eventType;
  final String serviceType;
  final Map<String, int> selectedMenuItems;
  final int guestCount;
  final DateTime eventDate;
  final String serviceTime;
  final String venueAddress;
  final DateTime createdAt;
  final String status; // pending, confirmed, cancelled
  final String? customerName;
  final String? customerPhone;
  final String? customerEmail;

  Booking({
    required this.id,
    required this.eventType,
    required this.serviceType,
    required this.selectedMenuItems,
    required this.guestCount,
    required this.eventDate,
    required this.serviceTime,
    required this.venueAddress,
    required this.createdAt,
    this.status = 'pending',
    this.customerName,
    this.customerPhone,
    this.customerEmail,
  });

  // Convert Booking to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventType': eventType,
      'serviceType': serviceType,
      'selectedMenuItems': selectedMenuItems,
      'guestCount': guestCount,
      'eventDate': Timestamp.fromDate(eventDate),
      'serviceTime': serviceTime,
      'venueAddress': venueAddress,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
    };
  }

  // Create Booking from Firestore document
  factory Booking.fromMap(Map<String, dynamic> map, String documentId) {
    return Booking(
      id: documentId,
      eventType: map['eventType'] ?? '',
      serviceType: map['serviceType'] ?? '',
      selectedMenuItems: Map<String, int>.from(map['selectedMenuItems'] ?? {}),
      guestCount: map['guestCount'] ?? 0,
      eventDate: (map['eventDate'] as Timestamp).toDate(),
      serviceTime: map['serviceTime'] ?? '',
      venueAddress: map['venueAddress'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: map['status'] ?? 'pending',
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      customerEmail: map['customerEmail'],
    );
  }

  // Create a copy with updated fields
  Booking copyWith({
    String? id,
    String? eventType,
    String? serviceType,
    Map<String, int>? selectedMenuItems,
    int? guestCount,
    DateTime? eventDate,
    String? serviceTime,
    String? venueAddress,
    DateTime? createdAt,
    String? status,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
  }) {
    return Booking(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      serviceType: serviceType ?? this.serviceType,
      selectedMenuItems: selectedMenuItems ?? this.selectedMenuItems,
      guestCount: guestCount ?? this.guestCount,
      eventDate: eventDate ?? this.eventDate,
      serviceTime: serviceTime ?? this.serviceTime,
      venueAddress: venueAddress ?? this.venueAddress,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
    );
  }
}
