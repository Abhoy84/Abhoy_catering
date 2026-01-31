import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../controllers/booking_controller.dart';
import 'confirmation_screen.dart';

class ReviewScreen extends StatelessWidget {
  final String eventType;
  final String serviceType;
  final Map<String, int> selectedMenuItems;
  final int guestCount;
  final DateTime eventDate;
  final String serviceTime;
  final String venueAddress;

  const ReviewScreen({
    super.key,
    required this.eventType,
    required this.serviceType,
    required this.selectedMenuItems,
    required this.guestCount,
    required this.eventDate,
    required this.serviceTime,
    required this.venueAddress,
  });

  Future<void> _submitBooking() async {
    final authController = Get.find<AuthController>();
    final bookingController = Get.find<BookingController>();

    // Check if user is signed in
    if (!authController.isSignedIn) {
      // Show login dialog
      final result = await _showLoginDialog();

      // If user didn't sign in, return
      if (result != true || !authController.isSignedIn) {
        return;
      }
    }

    // Submit booking
    final success = await bookingController.submitBooking(
      eventType: eventType,
      serviceType: serviceType,
      selectedMenuItems: selectedMenuItems,
      guestCount: guestCount,
      eventDate: eventDate,
      serviceTime: serviceTime,
      venueAddress: venueAddress,
    );

    if (success) {
      // Navigate to confirmation screen
      Get.to(
        () => ConfirmationScreen(
          bookingId: bookingController.currentBooking.value!.id
              .substring(0, 8)
              .toUpperCase(),
          eventType: eventType,
          selectedMenuItems: selectedMenuItems,
          guestCount: guestCount,
          eventDate: eventDate,
          serviceTime: serviceTime,
          venueAddress: venueAddress,
        ),
      );
    }
  }

  // Show login dialog
  Future<bool?> _showLoginDialog() async {
    final authController = Get.find<AuthController>();

    return Get.dialog<bool>(
      Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.restaurant_menu, color: AppColors.primaryOrange),
              const SizedBox(width: 12),
              const Text(
                'Sign In Required',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please sign in to save your booking',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (authController.isLoading.value)
                const CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  onPressed: () async {
                    final success = await authController.signInWithGoogle();
                    if (success) {
                      Get.back(result: true);
                    }
                  },
                  icon: const Icon(Icons.login, color: Colors.black87),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: authController.isLoading.value
                  ? null
                  : () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bookingController = Get.find<BookingController>();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
        title: Text(
          l10n?.reviewAndConfirm ?? 'Review & Confirm',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Details Card
            _buildSectionCard(
              title: l10n?.eventDetails ?? 'Event Details',
              icon: Icons.event,
              children: [
                _buildDetailRow(l10n?.eventType ?? 'Event Type', eventType),
                _buildDetailRow(
                  l10n?.serviceType ?? 'Service Type',
                  serviceType,
                ),
                _buildDetailRow(
                  l10n?.guestCount ?? 'Guest Count',
                  guestCount.toString(),
                ),
                _buildDetailRow(
                  l10n?.eventDate ?? 'Event Date',
                  '${eventDate.day}/${eventDate.month}/${eventDate.year}',
                ),
                _buildDetailRow(
                  l10n?.serviceTime ?? 'Service Time',
                  serviceTime,
                ),
                _buildDetailRow(l10n?.venue ?? 'Venue', venueAddress),
              ],
            ),

            const SizedBox(height: 16),

            // Menu Items Card
            _buildSectionCard(
              title: l10n?.selectedMenuItems ?? 'Selected Menu Items',
              icon: Icons.restaurant,
              children: selectedMenuItems.entries
                  .map(
                    (entry) =>
                        _buildDetailRow(entry.key, 'Qty: ${entry.value}'),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Confirm Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: bookingController.isSubmitting.value
                      ? null
                      : _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: bookingController.isSubmitting.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10n?.confirmAndSend ?? 'Confirm & Send',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryOrange),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
