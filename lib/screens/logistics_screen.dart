import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../controllers/locale_controller.dart';
import '../utils/app_colors.dart';
import 'review_screen.dart';

class LogisticsScreen extends StatefulWidget {
  final String eventType;
  final String serviceType;
  final Map<String, int> selectedMenuItems;

  const LogisticsScreen({
    super.key,
    required this.eventType,
    required this.serviceType,
    required this.selectedMenuItems,
  });

  @override
  State<LogisticsScreen> createState() => _LogisticsScreenState();
}

class _LogisticsScreenState extends State<LogisticsScreen> {
  int guestCount = 50;
  DateTime selectedDate = DateTime.now();
  String selectedServiceTime = 'Lunch';
  final TextEditingController venueController = TextEditingController();
  final TextEditingController guestCountController = TextEditingController(
    text: '50',
  );

  final List<String> serviceTimes = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  void dispose() {
    venueController.dispose();
    guestCountController.dispose();
    super.dispose();
  }

  void _updateGuestCount(int newCount) {
    if (newCount >= 20) {
      setState(() {
        guestCount = newCount;
        guestCountController.text = newCount.toString();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryOrange,
              onPrimary: Colors.white,
              onSurface: AppColors.textBlack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
            _buildFeatures(context, l10n),
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
                l10n?.appTitle ?? 'Digha Catering Services',
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
              _buildNavLink('About Us'),
              const SizedBox(width: 32),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(width: 16),
              Obx(() {
                final localeController = Get.find<LocaleController>();
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
                        'Language: ${LocaleController.getName(localeController.locale.languageCode).toUpperCase()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }),
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
                l10n?.step3Logistics ?? 'Step 3 of 5: Logistics',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                '60% Complete',
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
                widthFactor: 0.6, // 3/5 = 60%
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
            l10n?.nextMenuCustomization ?? 'Next: Menu Customization',
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
        children: [
          Text(
            l10n?.eventLogistics ?? 'Event Logistics',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.logisticsDesc ??
                'Tell us when and where the feast begins. We handle the rest.',
            style: TextStyle(fontSize: 16, color: AppColors.textGrey),
          ),
          const SizedBox(height: 60),
          // Form fields
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Guest Count
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.expectedGuestCount ?? 'Expected Guest Count',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: AppColors.primaryOrange,
                            ),
                            onPressed: () {
                              _updateGuestCount(guestCount - 1);
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: guestCountController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onChanged: (value) {
                                final newCount = int.tryParse(value);
                                if (newCount != null && newCount >= 20) {
                                  setState(() {
                                    guestCount = newCount;
                                  });
                                }
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.primaryOrange,
                            ),
                            onPressed: () {
                              _updateGuestCount(guestCount + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.minimumGuests ??
                          'Minimum 20 guests for standard catering',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Event Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.eventDate ?? 'Event Date',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primaryOrange,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Service Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.serviceTime ?? 'Service Time',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedServiceTime,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.access_time,
                            color: AppColors.primaryOrange,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textBlack,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedServiceTime = newValue;
                              });
                            }
                          },
                          items: serviceTimes.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Venue Address
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n?.venueAddress ?? 'Venue Address in Digha',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: venueController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      l10n?.venueHint ??
                      'Enter specific location (e.g., Near New Digha Sea Beach, Hotel Seashore Complex, or private residence in Old Digha)',
                  hintStyle: TextStyle(
                    color: AppColors.textGrey.withOpacity(0.6),
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryOrange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.primaryOrange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.serviceArea ??
                        'We serve all areas across Digha, Mandarmani, and Shankarpur.',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Buttons
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textBlack,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n?.back ?? 'Back',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to review screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(
                        eventType: widget.eventType,
                        serviceType: widget.serviceType,
                        selectedMenuItems: widget.selectedMenuItems,
                        guestCount: guestCount,
                        eventDate: selectedDate,
                        serviceTime: selectedServiceTime,
                        venueAddress: venueController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n?.continueToMenu ?? 'Continue to Menu',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: AppColors.offWhite,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      child: Row(
        children: [
          _buildFeatureCard(
            Icons.restaurant,
            l10n?.freshIngredients ?? 'Fresh Local Ingredients',
          ),
          const SizedBox(width: 32),
          _buildFeatureCard(
            Icons.set_meal,
            l10n?.seafoodSpecialists ?? 'Sea Food Specialists',
          ),
          const SizedBox(width: 32),
          _buildFeatureCard(
            Icons.verified,
            l10n?.licensedCaterers ?? 'Licensed Caterers',
          ),
          const SizedBox(width: 32),
          _buildFeatureCard(
            Icons.support_agent,
            l10n?.localSupport ?? '24/7 Local Support',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryOrange, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
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
            const SizedBox(width: 8),
            Text(
              '|',
              style: TextStyle(color: AppColors.textGrey.withOpacity(0.8)),
            ),
            const SizedBox(width: 8),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGrey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
