import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Reactive variables
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Getters
  User? get user => _user.value;
  bool get isSignedIn => _user.value != null;
  String? get userName => _user.value?.displayName;
  String? get userEmail => _user.value?.email;
  String? get userPhotoUrl => _user.value?.photoURL;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    _user.bindStream(_authService.authStateChanges);
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        Get.snackbar(
          'Success',
          'Welcome, ${userCredential.user?.displayName ?? "User"}!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return true;
      }
      return false;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Sign in failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      Get.snackbar(
        'Success',
        'Signed out successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign out failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign in anonymously (for testing)
  Future<void> signInAnonymously() async {
    try {
      isLoading.value = true;
      await _authService.signInAnonymously();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
