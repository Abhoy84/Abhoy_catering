import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  // Observable for selected navigation index
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void selectPage(int index) {
    _selectedIndex.value = index;
  }

  // Method to navigate to specific pages
  void goToDashboard() => selectPage(0);
  void goToBookings() => selectPage(1);
  void goToMenuManagement() => selectPage(2);
  void goToCustomers() => selectPage(3);
  void goToSettings() => selectPage(4);
}
