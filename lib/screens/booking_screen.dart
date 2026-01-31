import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../controllers/locale_controller.dart';
import '../utils/app_colors.dart';
import 'service_type_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedEventType;
  final TextEditingController customEventController = TextEditingController();

  @override
  void dispose() {
    customEventController.dispose();
    super.dispose();
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
            _buildFooter(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button and Logo
          Row(
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.primaryOrange,
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
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
          // Language Selector
          Obx(() {
            final localeController = Get.find<LocaleController>();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryOrange.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: localeController.locale,
                  icon: const Icon(
                    Icons.language,
                    size: 16,
                    color: AppColors.primaryOrange,
                  ),
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (Locale? newValue) {
                    if (newValue != null) {
                      localeController.setLocale(newValue);
                    }
                  },
                  items: LocaleController.supportedLocales
                      .map<DropdownMenuItem<Locale>>((Locale locale) {
                        return DropdownMenuItem<Locale>(
                          value: locale,
                          child: Row(
                            children: [
                              Text(
                                LocaleController.getFlag(locale.languageCode),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                LocaleController.getName(locale.languageCode),
                              ),
                            ],
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.bookingFunnel ?? 'BOOKING FUNNEL',
            style: const TextStyle(
              color: AppColors.primaryOrange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.step1EventType ?? 'Step 1: Event Type',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                '1 / 5',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
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
                widthFactor: 0.2, // 1/5 = 20%
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
            l10n?.planYourOccasion ?? 'Plan Your Special Occasion',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.selectEventType ??
                'Please select the type of event you are hosting in Digha.',
            style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          // Event type cards
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEventCard(
                context,
                l10n,
                'marriage',
                Icons.favorite,
                l10n?.marriage ?? 'Marriage',
                l10n?.marriageBengali ?? '(বিবাহ / शादी)',
              ),
              const SizedBox(width: 24),
              _buildEventCard(
                context,
                l10n,
                'birthday',
                Icons.cake,
                l10n?.birthday ?? 'Birthday',
                l10n?.birthdayBengali ?? '(জন্মদিন / जन्मदिन)',
              ),
              const SizedBox(width: 24),
              _buildEventCard(
                context,
                l10n,
                'ring_ceremony',
                Icons.diamond,
                l10n?.ringCeremony ?? 'Ring Ceremony',
                l10n?.ringCeremonyBengali ?? '(আংটি অনুষ্ঠান / रिंग)',
              ),
              const SizedBox(width: 24),
              _buildEventCard(
                context,
                l10n,
                'other',
                Icons.celebration,
                l10n?.otherEvent ?? 'Other Event',
                l10n?.otherEventBengali ?? '(অন্যান্য / अन्य)',
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Custom event input
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n?.cantFindEvent ?? 'Can\'t find your event? Type it here:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: customEventController,
                  decoration: InputDecoration(
                    hintText:
                        l10n?.customEventHint ??
                        'e.g. Corporate Meet, Anniversary',
                    hintStyle: TextStyle(
                      color: AppColors.textGrey.withOpacity(0.6),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        selectedEventType = 'custom';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Next Step Button
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: selectedEventType != null
                  ? () {
                      // Navigate to service type selection screen
                      final eventType = selectedEventType == 'custom'
                          ? customEventController.text
                          : selectedEventType!;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ServiceTypeScreen(eventType: eventType),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primaryOrange.withOpacity(
                  0.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n?.nextStep ?? 'Next Step',
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
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.pleaseSelectEvent ?? 'Please select an event to continue',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textGrey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    AppLocalizations? l10n,
    String eventType,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final isSelected = selectedEventType == eventType;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEventType = eventType;
          customEventController.clear();
        });
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            width: 2,
          ),
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
            // Icon container
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 48, color: AppColors.primaryOrange),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGrey.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            l10n?.copyright ??
                '© 2024 Digha Catering Services. All Rights Reserved.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textGrey.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.email_outlined),
                color: AppColors.textGrey,
                iconSize: 20,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.phone_outlined),
                color: AppColors.textGrey,
                iconSize: 20,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.location_on_outlined),
                color: AppColors.textGrey,
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
