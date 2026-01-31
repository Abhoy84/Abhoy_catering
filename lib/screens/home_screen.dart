import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../controllers/locale_controller.dart';
import '../utils/app_colors.dart';
import 'contact_screen.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildNavBar(context, isDesktop),
                _buildHeroSection(context, isDesktop),
                _buildSpecialtiesSection(context, isDesktop),
                _buildWhyChooseUsSection(context, isDesktop),
                _buildCTASection(context, isDesktop),
                _buildFooter(context, isDesktop),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.primaryOrange,
                child: const Icon(Icons.restaurant_menu, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.appTitle ?? 'Abhoy Catering',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          if (isDesktop)
            Row(
              children: [
                _navButton(l10n?.home ?? 'Home'),
                _navButton(l10n?.services ?? 'Services'),
                _navButton(l10n?.gallery ?? 'Gallery'),
                _navButton(l10n?.about ?? 'About'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactScreen(),
                      ),
                    );
                  },
                  child: Text(
                    l10n?.contact ?? 'Contact',
                    style: const TextStyle(color: AppColors.textBlack),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Obx(() {
                final localeController = Get.find<LocaleController>();
                return DropdownButtonHideUnderline(
                  child: DropdownButton<Locale>(
                    value: localeController.locale,
                    icon: const Icon(Icons.language, size: 20),
                    style: const TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 14,
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
                                Text(_getFlag(locale.languageCode)),
                                const SizedBox(width: 4),
                                Text(
                                  _getName(locale.languageCode).toUpperCase(),
                                ),
                              ],
                            ),
                          );
                        })
                        .toList(),
                  ),
                );
              }),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const BookingScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(l10n?.bookNow ?? 'Book Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isDesktop) {
    return Container(
      color: AppColors.offWhite,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _buildHeroContent()),
                const SizedBox(width: 40),
                Expanded(child: _buildHeroImage()),
              ],
            )
          : Column(
              children: [
                _buildHeroImage(),
                const SizedBox(height: 40),
                _buildHeroContent(),
              ],
            ),
    );
  }

  Widget _buildHeroContent() {
    // Need context to access l10n, but better to pass it or use Builder.
    // Since this is a method, we can use Builder or Consumer, or just pass context from parent.
    // Changing method signature requires changing call site.
    // Let's use a Builder to get context safely or rely on parent context availability if we change signature.
    // Actually, looking at previous step, I can get l10n from context inside if I pass context or use Builder.
    // But wait, the method signature in the file currently takes no arguments?
    // Yes: Widget _buildHeroContent() {
    // I need to change it to take context or use Builder.
    // Let's use Builder which is safer for context access if needed, OR just change signature since I'm rewriting the method.
    // I will use context from the build method where this is called.
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n?.bestInWestBengal ?? 'BEST IN WEST BENGAL',
                style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                  height: 1.1,
                ),
                children: [
                  TextSpan(
                    text:
                        l10n?.heroTitle ??
                        'Exquisite Catering in\nDigha \u2013 ',
                  ),
                  TextSpan(
                    text: l10n?.heroTitleHighlight ?? 'From Sea to\nPlate',
                    style: const TextStyle(
                      color: AppColors.primaryOrange,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n?.heroDescription ??
                  'Celebrate your special moments with the authentic soul of Bengal. We bring you the freshest catches from the Digha coast and traditional recipes passed down through generations.',
              style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingScreen(),
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
                  ),
                  child: Text(l10n?.startBooking ?? 'Start Booking'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryOrange,
                    side: const BorderSide(color: AppColors.primaryOrange),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(l10n?.viewMenu ?? 'View Menu'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '500+',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Text(
                      l10n?.eventsCatered ?? 'Events Catered',
                      style: const TextStyle(color: AppColors.textGrey),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4.9/5',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Text(
                      l10n?.customerRating ?? 'Customer Rating',
                      style: const TextStyle(color: AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeroImage() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAq7KKg_umrDwcXW60VPeILr12VEYgu2sOkMMvkSo1BGp78ZRIStVEX3EMDMnpcgnoCFqdEcNTpHnvjwboN7XE7D7dl7ATJTfGKAySmteMv-Acx7m0eVO5HEFHQnrhIQKh6P0O52qOhkoT3zB1Vbv6B-6DTnO5svFBmoIgM8SDdEKKvL3Hs3pH8RugJ8O9vp-m5a72byrLQYsij92Gv0_pKc0z2fFWMWFFo3c9aadkGsSCoGKCFLWd6VhK2YlTGHTOy2PwhW_9K1z0K',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.store, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n?.freshToday ?? 'Fresh Today',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        ),
                        Text(
                          l10n?.freshTodaySub ??
                              'Daily catch from Digha Mohona',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpecialtiesSection(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.tasteTheHeritage ?? 'TASTE THE HERITAGE',
            style: const TextStyle(
              color: AppColors.primaryOrange,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.culinarySpecialties ?? 'Our Culinary Specialties',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      l10n?.exploreFullMenu ?? 'Explore Full Menu',
                      style: const TextStyle(color: AppColors.primaryOrange),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.primaryOrange,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: _specialtyCard(
                        l10n?.specialty1Title ?? 'Coastal Delights',
                        l10n?.specialty1Desc ??
                            'Fresh Pomfret, Prawns, and Bhetki sourced daily.',
                        Icons.water,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAbAyxVYbKMhetxrmjZkl7XL4ipwoBM1vtgMQJTR_wY4Lkg6rlpr16t3Vr8dtGGqac_0xQ_g0jYGsk2MuyiH_bItR-bzUtmJYvWPQefX0232IBG4oYwBDJPmuBwm8NINDfL6BjTJZ7zPAgfYkDawKR_p0hzpnjQUzrrXnuwRqpgGv-PxT259dXOC60SxESx7WfQ9EtLPNMQ215UUw_SA9e2mo_3SdRCI-a21jOV8PtMtcmpiD3RDXERiU4CyK3xnN1Wl5UojOo3pMqr',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _specialtyCard(
                        l10n?.specialty2Title ?? 'Royal Thalis',
                        l10n?.specialty2Desc ??
                            'Authentic veg and non-veg traditional spreads.',
                        Icons.restaurant,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuD4WJ2O8JNvhXAg0u7mW5Lp2ZVidCiGeHo42P6CDQhfSsZQqJL-GxJF7qWUKdc1dzMa9Qb_dZyow8DUX7yRgTSJIvfz6xy3U3z0ky8z11QivKACCabVewJ87byT7uK57XS6mVTKKZJes86Chqh7ruZn2SKRevkIL1Qob4fxzdJZJju2BJ539srP02SAKImXc8cU_y7illVaHIwGwgz6jx6xhtHzy4-gphWfftI8xedrxDa2i8x75CRF85lmAQE8OInA2PMlp-RL5NIW',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _specialtyCard(
                        l10n?.specialty3Title ?? 'Weddings & Events',
                        l10n?.specialty3Desc ??
                            'Full-scale catering for grand celebrations.',
                        Icons.celebration,
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCJUH46DlP7is01eJXI7AVrpT1wTdXptqUHGcm55UZzXDq7m_2dVGmiAQ55kw6O4sk1dMyOx5m69ruh-rD-syWq8K-wmR6iEZ3iwBwxn2VngAVrtJF3JgLBlbQhXYm4QJdAFkXLPsDym4KKeYhRjZ5hy9nclf5UKX4FU_IwnvxBlKbUsohf_yPjILyCN2UjJZEnBpW2mUOEyZNdAR8-TxdvIv1ZHG4VLj-JhricHIzrd89XrjsEOtul8NjFnL4ce75HBuo-okQnI62t',
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _specialtyCard(
                      l10n?.specialty1Title ?? 'Coastal Delights',
                      l10n?.specialty1Desc ??
                          'Fresh Pomfret, Prawns, and Bhetki sourced daily.',
                      Icons.water,
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAbAyxVYbKMhetxrmjZkl7XL4ipwoBM1vtgMQJTR_wY4Lkg6rlpr16t3Vr8dtGGqac_0xQ_g0jYGsk2MuyiH_bItR-bzUtmJYvWPQefX0232IBG4oYwBDJPmuBwm8NINDfL6BjTJZ7zPAgfYkDawKR_p0hzpnjQUzrrXnuwRqpgGv-PxT259dXOC60SxESx7WfQ9EtLPNMQ215UUw_SA9e2mo_3SdRCI-a21jOV8PtMtcmpiD3RDXERiU4CyK3xnN1Wl5UojOo3pMqr',
                    ),
                    const SizedBox(height: 20),
                    _specialtyCard(
                      l10n?.specialty2Title ?? 'Royal Thalis',
                      l10n?.specialty2Desc ??
                          'Authentic veg and non-veg traditional spreads.',
                      Icons.restaurant,
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuD4WJ2O8JNvhXAg0u7mW5Lp2ZVidCiGeHo42P6CDQhfSsZQqJL-GxJF7qWUKdc1dzMa9Qb_dZyow8DUX7yRgTSJIvfz6xy3U3z0ky8z11QivKACCabVewJ87byT7uK57XS6mVTKKZJes86Chqh7ruZn2SKRevkIL1Qob4fxzdJZJju2BJ539srP02SAKImXc8cU_y7illVaHIwGwgz6jx6xhtHzy4-gphWfftI8xedrxDa2i8x75CRF85lmAQE8OInA2PMlp-RL5NIW',
                    ),
                    const SizedBox(height: 20),
                    _specialtyCard(
                      l10n?.specialty3Title ?? 'Weddings & Events',
                      l10n?.specialty3Desc ??
                          'Full-scale catering for grand celebrations.',
                      Icons.celebration,
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCJUH46DlP7is01eJXI7AVrpT1wTdXptqUHGcm55UZzXDq7m_2dVGmiAQ55kw6O4sk1dMyOx5m69ruh-rD-syWq8K-wmR6iEZ3iwBwxn2VngAVrtJF3JgLBlbQhXYm4QJdAFkXLPsDym4KKeYhRjZ5hy9nclf5UKX4FU_IwnvxBlKbUsohf_yPjILyCN2UjJZEnBpW2mUOEyZNdAR8-TxdvIv1ZHG4VLj-JhricHIzrd89XrjsEOtul8NjFnL4ce75HBuo-okQnI62t',
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _specialtyCard(
    String title,
    String subtitle,
    IconData icon,
    String imageUrl,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            // child: const Center(child: Text("Food Image")), // Removing text as we have real images now (or placeholders passed in)
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Icon(icon, color: AppColors.primaryOrange, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUsSection(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            l10n?.whyChooseUsTitle ?? 'Why Choose Abhay Catering?',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.whyChooseUsDesc ??
                'We combine years of culinary expertise with a deep love for Digha\'s local flavors.',
            style: const TextStyle(color: AppColors.textGrey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _featureItem(
                      Icons.local_shipping,
                      l10n?.feature1Title ?? 'Local Sourcing',
                      l10n?.feature1Desc ??
                          'Seafood sourced daily from Digha Mohona.',
                    ),
                    _featureItem(
                      Icons.verified_user,
                      l10n?.feature2Title ?? 'Hygienic Prep',
                      l10n?.feature2Desc ??
                          'Strict adherence to safety standards.',
                    ),
                    _featureItem(
                      Icons.settings,
                      l10n?.feature3Title ?? 'Tailored Menus',
                      l10n?.feature3Desc ??
                          'Customize every dish to suit your taste.',
                    ),
                    _featureItem(
                      Icons.people,
                      l10n?.feature4Title ?? 'Expert Team',
                      l10n?.feature4Desc ??
                          'Experienced chefs and attentive servers.',
                    ),
                  ],
                )
              : // On mobile, maybe a 2x2 grid or single column
                Column(
                  children: [
                    _featureItem(
                      Icons.local_shipping,
                      l10n?.feature1Title ?? 'Local Sourcing',
                      l10n?.feature1Desc ??
                          'Seafood sourced daily from Digha Mohona.',
                    ),
                    const SizedBox(height: 30),
                    _featureItem(
                      Icons.verified_user,
                      l10n?.feature2Title ?? 'Hygienic Prep',
                      l10n?.feature2Desc ??
                          'Strict adherence to safety standards.',
                    ),
                    const SizedBox(height: 30),
                    _featureItem(
                      Icons.settings,
                      l10n?.feature3Title ?? 'Tailored Menus',
                      l10n?.feature3Desc ??
                          'Customize every dish to suit your taste.',
                    ),
                    const SizedBox(height: 30),
                    _featureItem(
                      Icons.people,
                      l10n?.feature4Title ?? 'Expert Team',
                      l10n?.feature4Desc ??
                          'Experienced chefs and attentive servers.',
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title, String subtitle) {
    return SizedBox(
      width: 250,
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
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 40,
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.primaryOrange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isDesktop
            ? Row(
                children: [
                  Expanded(flex: 3, child: _ctaContent(context, l10n)),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: _ctaImage()),
                ],
              )
            : Column(
                children: [
                  _ctaContent(context, l10n),
                  const SizedBox(height: 40),
                  _ctaImage(),
                ],
              ),
      ),
    );
  }

  Widget _ctaContent(BuildContext context, AppLocalizations? l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.readyToPlan ?? 'Ready to host an unforgettable feast?',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n?.readyToPlanDesc ??
              'Start your booking process today. Choose your menu, pick a date, and let us handle the magic of flavors.',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(l10n?.startBooking ?? 'Start Booking'),
            ),
            const SizedBox(width: 24),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.call, color: Colors.white),
              label: Text(
                l10n?.phone ?? '+91 9876543210',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ctaImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBR-5C1a5vr3t9QLA0P969bjWiyUBiF3uqJftXoCtugJvOBq7r1M0XeNMkUWn8M_opsbDS4e4E3exWvJDbAZVn__g5XLCPPsHZeKeuAbei4K9gqRBkzSbuHj5WPjiFdHfBbjF46SoxD5AyQWiPzcNafhvZOp5isg53iWoFtLg1uwIaisGuHq0LJWZVvB2rhd52LOPVct0BKcEqkN51UuBH_mfFgInAT4cKvagIdHabOaoKzm-Zp5WTyIP9fK5tvnpqxUjWlxjsO8_bt',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context);
    return Container(
      color: AppColors.darkBackground,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _footerBrand(l10n)),
                    Expanded(
                      child: _footerLinks(l10n?.quickLinks ?? 'Quick Links', [
                        l10n?.specialMenu ?? 'Special Menu',
                        l10n?.weddingPackages ?? 'Wedding Packages',
                        l10n?.eventGallery ?? 'Event Gallery',
                        l10n?.privacyPolicy ?? 'Privacy Policy',
                      ]),
                    ),
                    Expanded(
                      child: _footerLinks(l10n?.services ?? 'Services', [
                        l10n?.weddingCatering ?? 'Wedding Catering',
                        l10n?.corporateEvents ?? 'Corporate Events',
                        l10n?.homeParties ?? 'Home Parties',
                        l10n?.beachParties ?? 'Beach Parties',
                      ]),
                    ),
                    Expanded(child: _footerContact(l10n)),
                  ],
                )
              : Column(
                  children: [
                    _footerBrand(l10n),
                    const SizedBox(height: 30),
                    _footerLinks(l10n?.quickLinks ?? 'Quick Links', [
                      l10n?.specialMenu ?? 'Special Menu',
                      l10n?.weddingPackages ?? 'Wedding Packages',
                      l10n?.eventGallery ?? 'Event Gallery',
                      l10n?.privacyPolicy ?? 'Privacy Policy',
                    ]),
                    const SizedBox(height: 30),
                    _footerLinks(l10n?.services ?? 'Services', [
                      l10n?.weddingCatering ?? 'Wedding Catering',
                      l10n?.corporateEvents ?? 'Corporate Events',
                      l10n?.homeParties ?? 'Home Parties',
                      l10n?.beachParties ?? 'Beach Parties',
                    ]),
                    const SizedBox(height: 30),
                    _footerContact(l10n),
                  ],
                ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2024 ${(l10n?.appTitle ?? 'Abhay Catering').toUpperCase()}. ${l10n?.rightsReserved ?? 'ALL RIGHTS RESERVED.'}',
                style: const TextStyle(color: Colors.white38, fontSize: 10),
              ),
              Row(
                children: [
                  Text(
                    l10n?.termsOfService ?? 'TERMS OF SERVICE',
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    l10n?.cookies ?? 'COOKIES',
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerBrand(AppLocalizations? l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.primaryOrange,
              child: const Icon(Icons.restaurant_menu, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              l10n?.appTitle ?? 'Abhay Catering',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          l10n?.footerDesc ??
              'Bringing the finest flavors of Digha and Bengal to your table since 2014. Quality, hygiene, and tradition are our hallmarks.',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _socialIcon(Icons.facebook),
            const SizedBox(width: 8),
            _socialIcon(Icons.share), // Placeholder for other social
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }

  Widget _footerLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              link,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footerContact(AppLocalizations? l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.visitUs ?? 'Visit Us',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryOrange,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l10n?.address ?? 'New Digha, West Bengal 721463',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.email, color: AppColors.primaryOrange, size: 16),
            const SizedBox(width: 8),
            Text(
              l10n?.email ?? 'info@abhaycatering.com',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.primaryOrange, size: 16),
            const SizedBox(width: 8),
            Text(
              l10n?.phone ?? '+91 987 654 3210',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  // Helper methods for locale display
  String _getFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇬🇧';
      case 'bn':
        return '🇧🇩';
      case 'hi':
        return '🇮🇳';
      default:
        return '🌐';
    }
  }

  String _getName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'bn':
        return 'বাংলা';
      case 'hi':
        return 'हिंदी';
      default:
        return languageCode;
    }
  }
}
