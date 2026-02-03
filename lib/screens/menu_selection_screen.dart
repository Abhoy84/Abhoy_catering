import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../controllers/menu_controller.dart';
import '../models/menu_item.dart';
import 'logistics_screen.dart';

class MenuSelectionScreen extends StatefulWidget {
  final String eventType;
  final String serviceType;

  const MenuSelectionScreen({
    super.key,
    required this.eventType,
    required this.serviceType,
  });

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  final MenuController _menuController = Get.put(MenuController());

  int currentCategoryIndex = 0; // Track current category
  final List<String> categories = [
    'Starters',
    'Main Course',
    'Desserts',
    'Drinks',
  ];
  Map<String, int> selectedItems = {};
  final TextEditingController searchController = TextEditingController();

  String get selectedCategory => categories[currentCategoryIndex];
  bool get isLastCategory => currentCategoryIndex == categories.length - 1;

  // Helper method to get filtered items for current category
  List<MenuItem> _getFilteredItems() {
    return _menuController.menuItems.where((item) {
      // Map database types to UI categories if needed, or ensure they match
      // DB: 'Starter', 'Main Course', 'Dessert', 'Drinks' (Assuming standard)
      // UI: 'Starters', 'Main Course', 'Desserts', 'Drinks'

      String type = item.type;
      // Normalize comparison
      String categoryTab = selectedCategory;

      if (categoryTab == 'Starters')
        return type == 'Starter' || type == 'Starters';
      if (categoryTab == 'Desserts')
        return type == 'Dessert' || type == 'Desserts';
      return type == categoryTab;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int getTotalItems() {
    return selectedItems.values.fold(0, (sum, qty) => sum + qty);
  }

  double getSubtotal() {
    double total = 0;
    selectedItems.forEach((itemName, quantity) {
      // Find item in all menu items
      final item = _menuController.menuItems.firstWhereOrNull(
        (item) => item.nameEn == itemName,
      );

      if (item != null) {
        total += item.price * quantity;
      }
    });
    return total;
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
                controller: searchController,
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

  Widget _buildMainContent(BuildContext context, AppLocalizations? l10n) {
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
                _buildCategoryTabs(),
                const SizedBox(height: 32),
                // Menu items grid
                _buildMenuGrid(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Your Plate sidebar
          SizedBox(width: 320, child: _buildYourPlateSidebar(context, l10n)),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final isSelected = currentCategoryIndex == index;
        final isCompleted = index < currentCategoryIndex;

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
    );
  }

  Widget _buildMenuGrid() {
    return Obx(() {
      if (_menuController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final items = _getFilteredItems();

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
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(items[index]);
        },
      );
    });
  }

  Widget _buildMenuItem(MenuItem item) {
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
          // Image
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: item.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
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
                    child: Icon(Icons.fastfood, size: 40, color: Colors.grey),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.nameEn,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (item.quantity.isNotEmpty) ...[
                          Text(
                            '${item.quantity} ${_formatUnit(item.unit)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
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
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: item.category == 'VEG'
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  // Showing English, Bengali and Hindi names
                  '${item.nameBn}. ${item.nameHi}',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textGrey.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.price.toInt()}${item.unit == 'Plate' || item.unit.isEmpty ? '/plate' : ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            selectedItems[item.nameEn] =
                                (selectedItems[item.nameEn] ?? 0) + 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourPlateSidebar(BuildContext context, AppLocalizations? l10n) {
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
                      '${getTotalItems()} Items Selected',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
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
            child: selectedItems.isEmpty
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
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final itemName = selectedItems.keys.elementAt(index);
                      final quantity = selectedItems[itemName]!;

                      final item = _menuController.menuItems.firstWhereOrNull(
                        (item) => item.nameEn == itemName,
                      );

                      if (item == null) return const SizedBox();

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
                                    item.nameEn,
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
                            Text(
                              '₹${item.price * quantity}',
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
                                setState(() {
                                  selectedItems.remove(itemName);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (selectedItems.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    selectedItems.clear();
                  });
                },
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Clear All Selection'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textGrey,
                ),
              ),
            ),
          ],
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
                  '₹${getSubtotal().toInt()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          // Next button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastCategory) {
                        // Navigate to Logistics screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogisticsScreen(
                              eventType: widget.eventType,
                              serviceType: widget.serviceType,
                              selectedMenuItems: selectedItems,
                            ),
                          ),
                        );
                      } else {
                        // Move to next category
                        setState(() {
                          currentCategoryIndex++;
                        });
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
                          isLastCategory
                              ? (l10n?.nextLogistics ?? 'Next: Logistics')
                              : 'Next: ${categories[currentCategoryIndex + 1]}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (currentCategoryIndex > 0) {
                        // Go to previous category
                        setState(() {
                          currentCategoryIndex--;
                        });
                      } else {
                        // On first category, go back to event selection
                        Navigator.pop(context);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textBlack,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          currentCategoryIndex > 0
                              ? 'Back: ${categories[currentCategoryIndex - 1]}'
                              : (l10n?.goBack ?? 'Go Back'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
          l10n?.menuFooter ??
              '© 2024 Digha Catering Services. Serving traditional Bengali flavors with modern elegance.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  String _formatUnit(String unit) {
    switch (unit) {
      case 'Weight (g)':
        return 'g';
      case 'Weight (kg)':
        return 'kg';
      case 'Pieces':
        return 'pcs';
      case 'Volume (ml)':
        return 'ml';
      default:
        return unit;
    }
  }
}
