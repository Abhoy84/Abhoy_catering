import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../controllers/menu_controller.dart';
import '../controllers/locale_controller.dart';
import '../controllers/menu_selection_controller.dart';
import '../models/menu_item.dart';
import 'logistics_screen.dart';

class MenuSelectionScreen extends StatelessWidget {
  final String eventType;
  final String serviceType;

  const MenuSelectionScreen({
    super.key,
    required this.eventType,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    // Put MenuController first as it is required by MenuSelectionController
    Get.put(MenuController());

    // Put the controller with a unique tag or standard dependency management
    // For simplicity with navigation args, we put it here.
    // Ideally this should be in a binding, but putting here works for this navigation flow.
    final MenuSelectionController controller = Get.put(
      MenuSelectionController(serviceType),
      tag: serviceType,
    );
    final LocaleController localeController = Get.find<LocaleController>();
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, l10n, controller, localeController),
            _buildProgressBar(context, l10n),
            _buildMainContent(context, l10n, controller, localeController),
            _buildFooter(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations? l10n,
    MenuSelectionController controller,
    LocaleController localeController,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          // Back button and Logo
          Row(
            children: [
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
          const SizedBox(width: 40),
          // Search bar
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: controller.updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search dishes...',
                  hintStyle: TextStyle(
                    color: AppColors.textGrey.withOpacity(0.6),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Language, Cart, User icons
          IconButton(
            icon: const Icon(Icons.language, size: 24),
            color: AppColors.textBlack,
            onPressed: () {
              // Show language selector
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Select Language',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Text(
                            '🇺🇸',
                            style: TextStyle(fontSize: 24),
                          ),
                          title: const Text('English'),
                          onTap: () {
                            localeController.setLanguage('en');
                            Navigator.pop(context);
                          },
                          trailing: localeController.locale.languageCode == 'en'
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.primaryOrange,
                                )
                              : null,
                        ),
                        ListTile(
                          leading: const Text(
                            '🇧🇩',
                            style: TextStyle(fontSize: 24),
                          ),
                          title: const Text('বাংলা'),
                          onTap: () {
                            localeController.setLanguage('bn');
                            Navigator.pop(context);
                          },
                          trailing: localeController.locale.languageCode == 'bn'
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.primaryOrange,
                                )
                              : null,
                        ),
                        ListTile(
                          leading: const Text(
                            '🇮🇳',
                            style: TextStyle(fontSize: 24),
                          ),
                          title: const Text('हिंदी'),
                          onTap: () {
                            localeController.setLanguage('hi');
                            Navigator.pop(context);
                          },
                          trailing: localeController.locale.languageCode == 'hi'
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.primaryOrange,
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 24),
            color: AppColors.textBlack,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, size: 24),
            color: AppColors.textBlack,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AppLocalizations? l10n) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.selectYourMenu ?? 'Select Your Menu',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.step2MenuDesc ??
                        'Step 2 of 5: Choose starters, mains and desserts',
                    style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                  ),
                ],
              ),
              Text(
                '40% Complete',
                style: TextStyle(
                  fontSize: 14,
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

  Widget _buildMainContent(
    BuildContext context,
    AppLocalizations? l10n,
    MenuSelectionController controller,
    LocaleController localeController,
  ) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menu items section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tabs
                _buildCategoryTabs(controller),
                const SizedBox(height: 32),
                // Menu items grid
                _buildMenuGrid(controller, localeController),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Your Plate sidebar
          SizedBox(
            width: 320,
            child: _buildYourPlateSidebar(
              context,
              l10n,
              controller,
              localeController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(MenuSelectionController controller) {
    return Obx(
      () => Row(
        children: controller.categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final isSelected = controller.currentCategoryIndex.value == index;
          final isCompleted = index < controller.currentCategoryIndex.value;

          return Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Column(
              children: [
                Row(
                  children: [
                    if (isCompleted)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    if (isCompleted) const SizedBox(width: 4),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? AppColors.primaryOrange
                            : isCompleted
                            ? Colors.green
                            : AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (isSelected)
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuGrid(
    MenuSelectionController controller,
    LocaleController localeController,
  ) {
    final MenuController menuDataController = Get.find<MenuController>();
    return Obx(() {
      if (menuDataController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final items = controller.filteredItems;

      if (items.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Text('No items found in this category'),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(items[index], controller, localeController);
        },
      );
    });
  }

  Widget _buildMenuItem(
    MenuItem item,
    MenuSelectionController controller,
    LocaleController localeController,
  ) {
    return Obx(() {
      final isSelected =
          controller.selectedItems.containsKey(item.nameEn) &&
          controller.selectedItems[item.nameEn]! > 0;

      return Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryOrange.withOpacity(0.05)
              : Colors.white,
          border: isSelected
              ? Border.all(color: AppColors.primaryOrange, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: item.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 32,
                              color: Colors.grey,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.fastfood, size: 32, color: Colors.grey),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            // Display name based on current locale
                            localeController.locale.languageCode == 'bn' &&
                                    item.nameBn.isNotEmpty
                                ? item.nameBn
                                : localeController.locale.languageCode ==
                                          'hi' &&
                                      item.nameHi.isNotEmpty
                                ? item.nameHi
                                : item.nameEn,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlack,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (controller.shouldShowPrice) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₹${item.price.toInt()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (item.quantity.isNotEmpty) ...[
                          Text(
                            '${item.quantity} ${_formatUnit(item.unit)}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: item.category == 'VEG'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item.category == 'VEG' ? 'Veg' : 'Non-Veg',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: item.category == 'VEG'
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Show English name as subtitle if current language is not English
                    if (localeController.locale.languageCode != 'en')
                      Text(
                        item.nameEn,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textGrey.withOpacity(0.8),
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Colors.green
                      : AppColors.primaryOrange,
                  disabledBackgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  elevation: 0,
                ),
                onPressed: isSelected
                    ? null
                    : () {
                        controller.addItem(item.nameEn);
                      },
                child: Text(
                  isSelected ? 'Added' : 'Add',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildYourPlateSidebar(
    BuildContext context,
    AppLocalizations? l10n,
    MenuSelectionController controller,
    LocaleController localeController,
  ) {
    final MenuController menuDataController = Get.find<MenuController>();

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
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.primaryOrange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.yourPlate ?? 'Your Plate',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      Text(
                        '${controller.totalItems} Items Selected',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Selected items list
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: controller.selectedItems.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          'No items selected yet',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.selectedItems.length,
                      itemBuilder: (context, index) {
                        final itemName = controller.selectedItems.keys
                            .elementAt(index);
                        final quantity = controller.selectedItems[itemName]!;

                        final item = menuDataController.menuItems
                            .firstWhereOrNull(
                              (item) => item.nameEn == itemName,
                            );

                        if (item == null) return const SizedBox();

                        // Determine display name
                        String displayName = item.nameEn;
                        if (localeController.locale.languageCode == 'bn' &&
                            item.nameBn.isNotEmpty) {
                          displayName = item.nameBn;
                        } else if (localeController.locale.languageCode ==
                                'hi' &&
                            item.nameHi.isNotEmpty) {
                          displayName = item.nameHi;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                    Text(
                                      'x $quantity Plate${quantity > 1 ? 's' : ''}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (controller.shouldShowPrice)
                                Text(
                                  '₹${item.price.toInt() * quantity}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                color: AppColors.textGrey,
                                onPressed: () {
                                  controller.removeItem(itemName);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (controller.selectedItems.isNotEmpty) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton.icon(
                  onPressed: controller.clearSelection,
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Clear All Selection'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textGrey,
                  ),
                ),
              ),
            ],
            if (controller.shouldShowPrice) ...[
              const Divider(height: 1),
              // Subtotal
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal (per plate)',
                      style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                    ),
                    Text(
                      '₹${controller.subtotal.toInt()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.isLastCategory) {
                          // Navigate to Logistics screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogisticsScreen(
                                eventType: eventType,
                                serviceType: serviceType,
                                selectedMenuItems: controller.selectedItems,
                              ),
                            ),
                          );
                        } else {
                          controller.nextCategory();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: AppColors.primaryOrange
                            .withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isLastCategory
                                ? (l10n?.nextLogistics ?? 'Next: Logistics')
                                : 'Next: ${controller.categories[controller.currentCategoryIndex.value + 1]}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (!controller.isLastCategory)
                            const Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
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
          const SizedBox(height: 16),
          Text(
            '© 2024 Abhay Catering Services. All Rights Reserved.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textGrey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  String _formatUnit(String unit) {
    if (unit.isEmpty) return 'Plate';
    if (unit == 'pcs') return 'Pcs';
    return unit;
  }
}
