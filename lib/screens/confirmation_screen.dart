import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../controllers/locale_controller.dart';
import '../utils/app_colors.dart';

class ConfirmationScreen extends StatefulWidget {
  final String bookingId;
  final String eventType;
  final Map<String, int> selectedMenuItems;
  final int guestCount;
  final DateTime eventDate;
  final String serviceTime;
  final String venueAddress;

  const ConfirmationScreen({
    super.key,
    required this.bookingId,
    required this.eventType,
    required this.selectedMenuItems,
    required this.guestCount,
    required this.eventDate,
    required this.serviceTime,
    required this.venueAddress,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final localeController = Get.find<LocaleController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
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
              _buildNavLink(l10n?.home ?? 'Home'),
              const SizedBox(width: 32),
              _buildNavLink(l10n?.menu ?? 'Menu'),
              const SizedBox(width: 32),
              _buildNavLink(l10n?.services ?? 'Services'),
              const SizedBox(width: 32),
              _buildNavLink(l10n?.about ?? 'About Us'),
              const SizedBox(width: 32),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.language, size: 20, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        localeController.locale.languageCode.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
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

  Widget _buildMainContent(BuildContext context, AppLocalizations? l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Column(
        children: [
          // Success Icon
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4ADE80).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4ADE80),
                    size: 60,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          // Success Title
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              l10n?.bookingRequestSent ?? 'Booking Request Sent Successfully!',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Booking ID
          Text(
            '${l10n?.bookingId ?? 'Booking ID'}: #DC-${widget.bookingId}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          // Description
          SizedBox(
            width: 600,
            child: Text(
              l10n?.bookingConfirmationDesc ??
                  'Thank you for choosing us! We have received your request and our local Digha office will contact you within 24 hours to finalize your special menu.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGrey,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
          // What happens next
          _buildNextStepsCard(context, l10n),
          const SizedBox(height: 60),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading PDF receipt...')),
                  );
                },
                icon: const Icon(Icons.download, size: 20),
                label: Text(l10n?.pdfReceipt ?? 'PDF Receipt'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textBlack,
                  side: BorderSide(color: Colors.grey.shade300, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening WhatsApp...')),
                  );
                },
                icon: const Icon(Icons.chat, size: 20),
                label: Text(l10n?.whatsappUs ?? 'WhatsApp Us'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.home, size: 20),
                label: Text(l10n?.backToHome ?? 'Back to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          // Add-on Services
          _buildAddOnServices(context, l10n),
        ],
      ),
    );
  }

  Widget _buildNextStepsCard(BuildContext context, AppLocalizations? l10n) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
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
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            l10n?.whatHappensNext ?? 'What happens next?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 32),
          _buildNextStep(
            Icons.check_circle,
            l10n?.requestReceived ?? 'Request Received',
            l10n?.requestReceivedDesc ??
                'Our team is reviewing your requirements',
            true,
          ),
          const SizedBox(height: 24),
          _buildNextStep(
            Icons.phone,
            l10n?.expertVerificationCall ?? 'Expert Verification Call',
            l10n?.expertVerificationCallDesc ??
                'Within 24 hours to finalize guest count & dishes',
            false,
          ),
          const SizedBox(height: 24),
          _buildNextStep(
            Icons.credit_card,
            l10n?.bookingConfirmation ?? 'Booking Confirmation',
            l10n?.bookingConfirmationDesc ??
                'Pay the advance to secure your dates',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildNextStep(
    IconData icon,
    String title,
    String description,
    bool isCompleted,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.primaryOrange
                : AppColors.primaryOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isCompleted ? Colors.white : AppColors.primaryOrange,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddOnServices(BuildContext context, AppLocalizations? l10n) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n?.makeItExtraSpecial ?? 'Make it Extra Special',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    l10n?.viewAll ?? 'View all',
                    style: const TextStyle(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryOrange,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n?.addOnServicesDesc ??
              'Complete your celebration with our popular add-on services',
          style: TextStyle(fontSize: 14, color: AppColors.textGrey),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _buildAddOnCard(
                'https://images.unsplash.com/photo-1490818387583-1baba5e638af?w=400',
                l10n?.flowerDecoration ?? 'Flower Decoration',
                l10n?.flowerDecorationDesc ??
                    'Traditional marigold & rose arrangements for your venue.',
                l10n?.enquireNow ?? 'Enquire Now',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildAddOnCard(
                'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=400',
                l10n?.photographyServices ?? 'Photography Services',
                l10n?.photographyServicesDesc ??
                    'Capture every smile with our award-winning photographers.',
                l10n?.enquireNow ?? 'Enquire Now',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildAddOnCard(
                'https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=400',
                l10n?.liveMusicBand ?? 'Live Music/Band',
                l10n?.liveMusicBandDesc ??
                    'Sufi, Folk, or Bollywood music to set the festive mood.',
                l10n?.enquireNow ?? 'Enquire Now',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddOnCard(
    String imageUrl,
    String title,
    String description,
    String buttonText,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryOrange,
                      side: const BorderSide(
                        color: AppColors.primaryOrange,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
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
        child: Text(
          l10n?.copyright ??
              '© 2024 Digha Catering Services. All rights reserved.\nPlot 105, New Digha, West Bengal',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
