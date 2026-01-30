import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../utils/app_colors.dart';
import 'confirmation_screen.dart';

class ReviewScreen extends StatefulWidget {
  final String eventType;
  final Map<String, int> selectedMenuItems;
  final int guestCount;
  final DateTime eventDate;
  final String serviceTime;
  final String venueAddress;

  const ReviewScreen({
    super.key,
    required this.eventType,
    required this.selectedMenuItems,
    required this.guestCount,
    required this.eventDate,
    required this.serviceTime,
    required this.venueAddress,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, l10n),
            _buildProgressBar(context, l10n),
            _buildMainContent(context, l10n),
            _buildFooter(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.appTitle ?? 'Digha Catering',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          // Navigation
          Row(
            children: [
              _buildNavLink('Home'),
              const SizedBox(width: 32),
              _buildNavLink('Menu'),
              const SizedBox(width: 32),
              _buildNavLink('Gallery'),
              const SizedBox(width: 32),
              _buildNavLink('Contact'),
              const SizedBox(width: 32),
              Consumer<LocaleProvider>(
                builder: (context, provider, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.language, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'BN / EN',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.step4Review ?? 'Step 4 of 5',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                '80% Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8, // 4/5 = 80%
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.reviewExportSummary ?? 'Review & Export Summary',
            style: TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Column(
              children: [
                Text(
                  l10n?.finalReviewTitle ??
                      'Final Review: Let\'s make your event in Digha perfect.',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n?.finalReviewDesc ??
                      'Please double-check your event details and menu selections before confirming.',
                  style: TextStyle(fontSize: 16, color: AppColors.textGrey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          // Event Quick-Look and Menu Selection
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Quick-Look
              Expanded(flex: 2, child: _buildEventQuickLook(context, l10n)),
            ],
          ),
          const SizedBox(height: 40),
          // Selected Menu
          _buildSelectedMenu(context, l10n),
          const SizedBox(height: 60),
          // Action Buttons
          _buildActionButtons(context, l10n),
        ],
      ),
    );
  }

  Widget _buildEventQuickLook(BuildContext context, AppLocalizations? l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Event Image
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=400',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Event Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n?.eventQuickLook ?? 'Event Quick-Look',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.primaryOrange,
                        ),
                        label: Text(
                          l10n?.editDetails ?? 'Edit Details',
                          style: const TextStyle(
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.eventType,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Date and Time
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          Icons.calendar_today,
                          l10n?.date ?? 'DATE',
                          '${widget.eventDate.day}th ${_getMonthName(widget.eventDate.month)} ${widget.eventDate.year}',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildInfoItem(
                          Icons.access_time,
                          l10n?.time ?? 'TIME',
                          '${widget.serviceTime} onwards',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Guests and Location
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          Icons.people,
                          l10n?.guests ?? 'GUESTS',
                          '${widget.guestCount} People',
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildInfoItem(
                          Icons.location_on,
                          l10n?.location ?? 'LOCATION',
                          widget.venueAddress.length > 20
                              ? '${widget.venueAddress.substring(0, 20)}...'
                              : widget.venueAddress,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primaryOrange),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedMenu(BuildContext context, AppLocalizations? l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.theSelectedMenu ?? 'The Selected Menu',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  l10n?.changeSelection ?? 'Change Selection',
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Starters
          _buildMenuCategory(
            Icons.restaurant,
            l10n?.starters ?? 'Starters',
            _getMenuItemsForDisplay(),
          ),
          const SizedBox(height: 24),
          // Mains
          _buildMenuCategory(
            Icons.set_meal,
            l10n?.mains ?? 'Mains',
            _getMenuItemsForDisplay(),
          ),
          const SizedBox(height: 24),
          // Desserts
          _buildMenuCategory(
            Icons.cake,
            l10n?.desserts ?? 'Desserts',
            _getMenuItemsForDisplay(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCategory(
    IconData icon,
    String title,
    List<Map<String, String>> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryOrange, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 40,
          runSpacing: 12,
          children: items.map((item) {
            return SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item['name']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: item['type'] == 'Veg'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item['type']!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: item['type'] == 'Veg'
                            ? Colors.green[700]
                            : Colors.red[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item['label']!,
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.readyToProceed ?? 'Ready to proceed?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n?.downloadQuoteDesc ??
                      'Download your quote for reference or confirm to book now.',
                  style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading PDF...')),
              );
            },
            icon: const Icon(Icons.download, size: 20),
            label: Text(l10n?.downloadPdf ?? 'Download PDF'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryOrange,
              side: const BorderSide(color: AppColors.primaryOrange, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Generate a random booking ID
              final bookingId = DateTime.now().millisecondsSinceEpoch
                  .toString()
                  .substring(7);

              // Navigate to confirmation screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmationScreen(
                    bookingId: bookingId,
                    eventType: widget.eventType,
                    selectedMenuItems: widget.selectedMenuItems,
                    guestCount: widget.guestCount,
                    eventDate: widget.eventDate,
                    serviceTime: widget.serviceTime,
                    venueAddress: widget.venueAddress,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.send, size: 20),
            label: Text(
              l10n?.confirmSend ?? 'Confirm & Send via\nWhatsApp/Email',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n?.copyright ??
                  '© 2023 Digha Catering Services. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGrey.withOpacity(0.8),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(width: 16),
            Text(
              'Terms of Service',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(width: 16),
            Text(
              'FAQ',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  List<Map<String, String>> _getMenuItemsForDisplay() {
    // Sample data - in real app, this would come from selectedMenuItems
    return [
      {
        'name': 'Fish Kabiraji (Signature)',
        'type': 'Non-Veg',
        'label': 'Non-Veg',
      },
      {'name': 'Paneer Tikka', 'type': 'Veg', 'label': 'Veg'},
      {'name': 'Crispy Babycorn', 'type': 'Veg', 'label': 'Veg'},
    ];
  }
}
