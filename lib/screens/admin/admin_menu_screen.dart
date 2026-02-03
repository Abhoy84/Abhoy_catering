import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../controllers/menu_controller.dart';
import '../../models/menu_item.dart';
import 'add_menu_item_screen.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  final MenuController _menuController = Get.put(MenuController());

  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'All Items',
    'Starter',
    'Main Course',
    'Dessert',
    'Drinks',
  ];

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  List<MenuItem> get _filteredItems {
    List<MenuItem> items;
    if (_selectedCategoryIndex == 0) {
      items = _menuController.menuItems;
    } else {
      String type = _categories[_selectedCategoryIndex];
      items = _menuController.menuItems.where((i) => i.type == type).toList();
    }
    return items;
  }

  List<MenuItem> get _paginatedItems {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(
      0,
      _filteredItems.length,
    );
    if (startIndex >= _filteredItems.length) return [];
    return _filteredItems.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    // Return content directly without Scaffold since it's embedded in AdminDashboardScreen
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumbs(),
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 32),
            _buildCategoryTabs(),
            const SizedBox(height: 24),
            _buildMenuTable(),
            const SizedBox(height: 24),
            Obx(() {
              // Re-build pagination when menu items change
              if (_filteredItems.isEmpty) return const SizedBox.shrink();
              return _buildPagination();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Row(
      children: [
        Text(
          'Dashboard',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('/', style: TextStyle(color: Colors.grey)),
        ),
        const Text(
          'Menu Management',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Management',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your catering food items, prices, and daily availability.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => Get.to(() => const AddMenuItemScreen()),
          icon: const Icon(
            Icons.add_circle_outline,
            size: 20,
            color: Colors.white,
          ),
          label: const Text(
            'Add New Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
                _currentPage = 1; // Reset to first page when category changes
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              margin: const EdgeInsets.only(right: 32),
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(
                        bottom: BorderSide(
                          color: AppColors.primaryOrange,
                          width: 3,
                        ),
                      )
                    : null,
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Obx(() {
            if (_menuController.isLoading.value) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (_filteredItems.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(child: Text("No items found")),
              );
            }

            return Column(
              children: _paginatedItems
                  .map((item) => _buildMenuItem(item))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 1, child: _headerText('IMAGE')),
          Expanded(flex: 3, child: _headerText('DISH DETAILS (MULTI-LANG)')),
          Expanded(flex: 2, child: _headerText('QTY & DESC')),
          Expanded(flex: 1, child: _headerText('PRICE/PLATE')),
          Expanded(flex: 2, child: _headerText('AVAILABILITY')),
          Expanded(
            flex: 1,
            child: _headerText('ACTIONS', align: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _headerText(String text, {TextAlign align = TextAlign.start}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(right: 16),
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.imageUrl.isNotEmpty
                    ? Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.fastfood),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nameEn,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'BN: ${item.nameBn} | HI: ${item.nameHi}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  'Category: ${item.category} | Type: ${item.type}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.quantity.isNotEmpty)
                  Text(
                    '${item.quantity} ${_formatUnit(item.unit)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF333333),
                    ),
                  ),
                if (item.description.isNotEmpty) ...[
                  if (item.quantity.isNotEmpty) const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (item.quantity.isEmpty && item.description.isEmpty)
                  Text('-', style: TextStyle(color: Colors.grey[400])),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '₹${item.price}',
                style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: item.isAvailable,
                    activeColor: Colors.white,
                    activeTrackColor: AppColors.primaryOrange,
                    inactiveThumbColor: Colors.grey[400],
                    inactiveTrackColor: Colors.grey[200],
                    onChanged: (val) {
                      item.isAvailable = val;
                      _menuController.updateMenuItem(item);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.isAvailable ? 'Available' : 'Sold Out',
                  style: TextStyle(
                    color: item.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Get.to(() => AddMenuItemScreen(itemToEdit: item));
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Delete Item',
                      titlePadding: const EdgeInsets.only(top: 20),
                      contentPadding: const EdgeInsets.all(20),
                      middleText:
                          'Are you sure you want to delete this menu item?\nThis action cannot be undone.',
                      confirm: ElevatedButton(
                        onPressed: () {
                          _menuController.deleteMenuItem(item.id);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Delete'),
                      ),
                      cancel: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                        ),
                        child: const Text('Cancel'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    final totalItems = _filteredItems.length;
    final totalPages = (totalItems / _itemsPerPage).ceil();

    if (totalItems == 0) return const SizedBox.shrink();

    final int startItem = (_currentPage - 1) * _itemsPerPage + 1;
    final int endItem = (_currentPage * _itemsPerPage).clamp(0, totalItems);

    return Row(
      children: [
        Text(
          'Showing $startItem-$endItem of $totalItems items',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: _currentPage > 1
              ? () {
                  setState(() {
                    _currentPage--;
                  });
                }
              : null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
            foregroundColor: Colors.grey[700],
          ),
          child: const Text('Prev'),
        ),
        const SizedBox(width: 8),
        for (int i = 1; i <= totalPages; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _currentPage = i;
                });
              },
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _currentPage == i
                      ? AppColors.primaryOrange
                      : Colors.transparent,
                  border: Border.all(
                    color: _currentPage == i
                        ? AppColors.primaryOrange
                        : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: _currentPage == i ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: _currentPage < totalPages
              ? () {
                  setState(() {
                    _currentPage++;
                  });
                }
              : null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
            foregroundColor: Colors.grey[700],
          ),
          child: const Text('Next'),
        ),
      ],
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
