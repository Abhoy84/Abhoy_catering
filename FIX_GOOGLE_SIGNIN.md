# 🔧 Fix Google Sign-In for Windows

## ❌ Current Error:
```
ClientID not set. Either set it on a <meta name="google-signin-client_id" content="CLIENT_ID" /> tag, 
or pass clientId when initializing GoogleSignIn
```

## ✅ Solution: Add Web Client ID

### Step 1: Get Your Web Client ID from Firebase

1. **Go to Firebase Console**: https://console.firebase.google.com/
2. **Select your project**: abhoy-catering
3. **Click the gear icon** ⚙️ → **Project settings**
4. **Scroll down to "Your apps"**
5. **Find your Web app** (the one you created earlier)
6. **You'll see something like this:**

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyBm2vuabRRT8547-GSqMezUhpuTPi6Snbg",
  authDomain: "abhoy-catering.firebaseapp.com",
  projectId: "abhoy-catering",
  storageBucket: "abhoy-catering.firebasestorage.app",
  messagingSenderId: "39101208413",
  appId: "1:39101208413:web:21a208a27a314ec95e7ab4"
};
```

### Step 2: Get OAuth Client ID

1. **In the same Project Settings page**
2. **Scroll to "Service accounts"** tab
3. **OR go to**: https://console.cloud.google.com/apis/credentials
4. **Select your project**: abhoy-catering
5. **Look for "OAuth 2.0 Client IDs"**
6. **Find the Web client** (auto created by Google)
7. **Copy the Client ID** - it looks like:
   ```
   39101208413-xxxxxxxxxxxxxxxxx.apps.googleusercontent.com
   ```

### Step 3: Update auth_service.dart

Replace the clientId in `lib/services/auth_service.dart`:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: 'YOUR_ACTUAL_CLIENT_ID_HERE.apps.googleusercontent.com',
  scopes: ['email', 'profile'],
);
```

---

## 🚀 Quick Fix (For Testing):

If you want to test without web client ID, you can temporarily disable Google Sign-In for Windows and use anonymous auth:

### Option 1: Use Anonymous Auth (Testing Only)

Update `auth_service.dart`:

```dart
// Sign in anonymously for testing
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
```

### Option 2: Make Login Optional

Update `review_screen.dart` to allow booking without login:

```dart
// Comment out the login check temporarily
// if (!_authService.isSignedIn) {
//   // Show login screen
//   ...
// }
```

---

## 📝 Complete Setup Steps:

### For Production (Recommended):

1. **Enable Google Sign-In in Firebase Console**:
   - Authentication → Sign-in method → Google → Enable

2. **Get Web Client ID**:
   - Project Settings → Your apps → Web app
   - OR Google Cloud Console → APIs & Credentials

3. **Update auth_service.dart**:
   - Replace `clientId` with your actual client ID

4. **Restart the app**:
   ```powershell
   flutter run -d windows
   ```

### For Quick Testing:

1. **Make login optional** (see Option 2 above)
2. **OR use anonymous auth** (see Option 1 above)
3. **Test the booking flow without Google Sign-In**
4. **Add Google Sign-In later**

---

## 🔍 Finding Your Client ID:

### Method 1: Firebase Console
```
Firebase Console → Project Settings → General → Your apps → Web app
Look for: "Web client ID" or check the SDK setup code
```

### Method 2: Google Cloud Console
```
https://console.cloud.google.com/apis/credentials
Select project → OAuth 2.0 Client IDs → Web client (auto created by Google)
```

### Method 3: Check firebase_options.dart
The web client ID is related to your project. It should be:
```
[PROJECT_NUMBER]-[RANDOM_STRING].apps.googleusercontent.com
```

Where PROJECT_NUMBER is: `39101208413` (from your config)

---

## ⚠️ Common Issues:

### Error: "ClientID not set"
**Solution**: Add clientId to GoogleSignIn initialization

### Error: "Invalid client ID"
**Solution**: Make sure you're using the Web client ID, not Android or iOS

### Error: "Unauthorized"
**Solution**: Enable Google Sign-In in Firebase Console → Authentication

---

## 🎯 What to Do Right Now:

**Option A: Get Client ID (5 minutes)**
1. Go to Firebase Console
2. Get your Web OAuth Client ID
3. Update `auth_service.dart`
4. Restart app
5. ✅ Google Sign-In works!

**Option B: Skip for Now (30 seconds)**
1. Comment out login requirement in `review_screen.dart`
2. Test booking without auth
3. Add Google Sign-In later

---

**Which option would you like to proceed with?**

Send me your Web Client ID and I'll update the code, OR I can make login optional for now!
