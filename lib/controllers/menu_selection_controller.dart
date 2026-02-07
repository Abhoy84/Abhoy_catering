import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import '../models/menu_item.dart';
import 'menu_controller.dart';

class MenuSelectionController extends GetxController {
  final String serviceType;
  final MenuController _menuDataController = Get.find<MenuController>();

  MenuSelectionController(this.serviceType);

  // Observable state
  final RxInt currentCategoryIndex = 0.obs;
  final RxMap<String, int> selectedItems = <String, int>{}.obs;
  final RxString searchQuery = ''.obs;
  final TextEditingController searchInputController = TextEditingController();

  // Computed properties
  late final List<String> categories;
  late final bool shouldShowPrice;

  @override
  void onInit() {
    super.onInit();
    _initializeConfig();

    // Listen to search controller
    searchInputController.addListener(() {
      searchQuery.value = searchInputController.text;
    });
  }

  @override
  void onClose() {
    searchInputController.dispose();
    super.onClose();
  }

  void _initializeConfig() {
    // Configure based on service type
    if (serviceType == 'only_starter') {
      categories = ['Starters'];
    } else if (serviceType == 'mocktail') {
      categories = ['Drinks'];
    } else {
      categories = ['Starters', 'Main Course', 'Desserts', 'Drinks'];
    }

    // Configure price visibility
    // cook_and_serve and only_cook -> hide price
    if (serviceType == 'cook_and_serve' || serviceType == 'only_cook') {
      shouldShowPrice = false;
    } else {
      shouldShowPrice = true;
    }
  }

  // Getters
  String get selectedCategory => categories[currentCategoryIndex.value];
  bool get isLastCategory =>
      currentCategoryIndex.value == categories.length - 1;

  // Methods
  void nextCategory() {
    if (!isLastCategory) {
      currentCategoryIndex.value++;
    }
  }

  void addItem(String itemName) {
    selectedItems[itemName] = (selectedItems[itemName] ?? 0) + 1;
  }

  void removeItem(String itemName) {
    selectedItems.remove(itemName);
  }

  void clearSelection() {
    selectedItems.clear();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  int get totalItems => selectedItems.values.fold(0, (sum, qty) => sum + qty);

  double get subtotal {
    double total = 0;
    selectedItems.forEach((itemName, quantity) {
      final item = _menuDataController.menuItems.firstWhereOrNull(
        (item) => item.nameEn == itemName,
      );
      if (item != null) {
        total += item.price * quantity;
      }
    });
    return total;
  }

  List<MenuItem> get filteredItems {
    return _menuDataController.menuItems.where((item) {
      if (!item.isAvailable) return false;

      // Search filter
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        if (!item.nameEn.toLowerCase().contains(query) &&
            !item.nameBn.toLowerCase().contains(query) &&
            !item.nameHi.toLowerCase().contains(query)) {
          return false;
        }
      }

      String type = item.type;
      String categoryTab = selectedCategory;

      if (categoryTab == 'Starters')
        return type == 'Starter' || type == 'Starters';
      if (categoryTab == 'Desserts')
        return type == 'Dessert' || type == 'Desserts';
      return type == categoryTab;
    }).toList();
  }
}
