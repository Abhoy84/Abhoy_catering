import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/menu_item.dart';
import '../services/firebase_service.dart';

class MenuController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  // Reactive list of menu items
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;
  final RxList<MenuItem> vegItems = <MenuItem>[].obs;
  final RxList<MenuItem> nonVegItems = <MenuItem>[].obs;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Bind the stream to the reactive list
    menuItems.bindStream(_firebaseService.getMenuItems());

    // Listen to changes in menuItems to update filtered lists
    ever(menuItems, (_) {
      vegItems.value = menuItems
          .where((item) => item.category == 'VEG')
          .toList();
      nonVegItems.value = menuItems
          .where((item) => item.category == 'NON-VEG')
          .toList();
      isLoading.value = false;
    });
  }

  Future<bool> addMenuItem(MenuItem item) async {
    try {
      isLoading.value = true;
      await _firebaseService.addMenuItem(item);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      _showErrorSnackbar('Failed to add menu item: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateMenuItem(MenuItem item) async {
    try {
      isLoading.value = true;
      await _firebaseService.updateMenuItem(item);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      _showErrorSnackbar('Failed to update menu item: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteMenuItem(String id) async {
    try {
      await _firebaseService.deleteMenuItem(id);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      _showErrorSnackbar('Failed to delete menu item: $e');
      return false;
    }
  }

  Future<String?> uploadImage(File file) async {
    try {
      isLoading.value = true;
      String path = 'menu_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      String url = await _firebaseService.uploadImage(file, path);
      return url;
    } catch (e) {
      errorMessage.value = e.toString();
      _showErrorSnackbar('Image upload failed: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    if (Get.context != null) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white, size: 28),
        margin: const EdgeInsets.all(20),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
        maxWidth: 400,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
