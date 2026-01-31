import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize GoogleSignIn with web client ID
  // For Windows/Web, we need to specify the client ID
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '39101208413-5da9tarsm9kopq67bv665nhk9m06djcl.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  // Get user display name
  String? get userName => _auth.currentUser?.displayName;

  // Get user email
  String? get userEmail => _auth.currentUser?.email;

  // Get user photo URL
  String? get userPhotoUrl => _auth.currentUser?.photoURL;

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      print('✅ Signed in: ${userCredential.user?.displayName}');
      return userCredential;
    } catch (e) {
      print('❌ Error signing in with Google: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
      print('✅ Signed out successfully');
    } catch (e) {
      print('❌ Error signing out: $e');
      rethrow;
    }
  }

  // Sign in anonymously (optional - for testing)
  Future<UserCredential> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      print('✅ Signed in anonymously');
      return userCredential;
    } catch (e) {
      print('❌ Error signing in anonymously: $e');
      rethrow;
    }
  }
}
