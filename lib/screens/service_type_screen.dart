import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../controllers/locale_controller.dart';
import '../utils/app_colors.dart';
import 'menu_selection_screen.dart';
import 'logistics_screen.dart';

class ServiceTypeScreen extends StatefulWidget {
  final String eventType;

  const ServiceTypeScreen({super.key, required this.eventType});

  @override
  State<ServiceTypeScreen> createState() => _ServiceTypeScreenState();
}

class _ServiceTypeScreenState extends State<ServiceTypeScreen>
    with SingleTickerProviderStateMixin {
  String? selectedServiceType;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<ServiceTypeOption> serviceTypes = [
    ServiceTypeOption(
      id: 'all_contract',
      icon: Icons.restaurant,
      gradient: const LinearGradient(
        colors: [Color(0xFFFF8C00), Color(0xFFFF6B00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ServiceTypeOption(
      id: 'cook_and_serve',
      icon: Icons.room_service,
      gradient: const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ServiceTypeOption(
      id: 'only_cook',
      icon: Icons.soup_kitchen,
      gradient: const LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ServiceTypeOption(
      id: 'only_serve',
      icon: Icons.delivery_dining,
      gradient: const LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ServiceTypeOption(
      id: 'only_starter',
      icon: Icons.local_dining,
      gradient: const LinearGradient(
        colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ServiceTypeOption(
      id: 'mocktail',
      icon: Icons.local_bar,
      gradient: const LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.appTitle ?? 'Abhay Catering',
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
                l10n?.step2ServiceType ?? 'Step 2: Service Type',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                '2 / 5',
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
                widthFactor: 0.4, // 2/5 = 40%
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
        child: Column(
          children: [
            // Title
            Text(
              l10n?.selectServiceType ?? 'Select Your Service Type',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.serviceTypeDesc ??
                  'Choose the type of service that best fits your ${widget.eventType} celebration',
              style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            // Service type cards - First row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[0],
                  l10n?.allContract ?? 'All Contract',
                  l10n?.allContractDesc ??
                      'Complete catering solution with cooking, serving, and cleanup',
                  l10n?.allContractBengali ??
                      '(সম্পূর্ণ চুক্তি / पूर्ण अनुबंध)',
                ),
                const SizedBox(width: 24),
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[1],
                  l10n?.cookAndServe ?? 'Cook & Serve',
                  l10n?.cookAndServeDesc ??
                      'Professional cooking and serving staff for your event',
                  l10n?.cookAndServeBengali ??
                      '(রান্না ও পরিবেশন / खाना बनाना और परोसना)',
                ),
                const SizedBox(width: 24),
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[2],
                  l10n?.onlyCook ?? 'Only Cook',
                  l10n?.onlyCookDesc ??
                      'Expert chefs to prepare delicious meals at your venue',
                  l10n?.onlyCookBengali ??
                      '(শুধুমাত্র রান্না / केवल खाना बनाना)',
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Service type cards - Second row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[3],
                  l10n?.onlyServe ?? 'Only Serve',
                  l10n?.onlyServeDesc ??
                      'Professional serving staff for your prepared food',
                  l10n?.onlyServeBengali ?? '(শুধুমাত্র পরিবেশন / केवल परोसना)',
                ),
                const SizedBox(width: 24),
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[4],
                  l10n?.onlyStarter ?? 'Only Starter',
                  l10n?.onlyStarterDesc ??
                      'Delicious appetizers and starters for your guests',
                  l10n?.onlyStarterBengali ??
                      '(শুধুমাত্র স্টার্টার / केवल स्टार्टर)',
                ),
                const SizedBox(width: 24),
                _buildServiceCard(
                  context,
                  l10n,
                  serviceTypes[5],
                  l10n?.mocktail ?? 'Mocktail Service',
                  l10n?.mocktailDesc ??
                      'Refreshing mocktails and beverages for your celebration',
                  l10n?.mocktailBengali ?? '(মকটেল / मॉकटेल)',
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Next Step Button
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: selectedServiceType != null
                    ? () {
                        if (selectedServiceType == 'only_serve') {
                          // Skip Menu Selection for Only Serve
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogisticsScreen(
                                eventType: widget.eventType,
                                serviceType: selectedServiceType!,
                                selectedMenuItems: const {},
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuSelectionScreen(
                                eventType: widget.eventType,
                                serviceType: selectedServiceType!,
                              ),
                            ),
                          );
                        }
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
                      l10n?.nextStep ?? 'Next: Menu Selection',
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
              l10n?.pleaseSelectService ??
                  'Please select a service type to continue',
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

  Widget _buildServiceCard(
    BuildContext context,
    AppLocalizations? l10n,
    ServiceTypeOption option,
    String title,
    String description,
    String subtitle,
  ) {
    final isSelected = selectedServiceType == option.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedServiceType = option.id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 240,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryOrange.withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 4),
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: option.gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: option.gradient.colors.first.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(option.icon, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle (multilingual)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textGrey.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            // Selection indicator
            if (isSelected)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n?.selected ?? 'Selected',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
      child: Column(
        children: [
          Text(
            l10n?.copyright ??
                '© 2024 Abhay Catering Services. All Rights Reserved.',
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

class ServiceTypeOption {
  final String id;
  final IconData icon;
  final Gradient gradient;

  ServiceTypeOption({
    required this.id,
    required this.icon,
    required this.gradient,
  });
}
