# Quick Start - Firebase Setup
# Run these commands in order

Write-Host "🚀 Abhoy Catering - Firebase Setup" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host ""

# Check if Firebase CLI is installed
Write-Host "Step 1: Checking Firebase CLI..." -ForegroundColor Yellow
try {
    $firebaseVersion = firebase --version
    Write-Host "✅ Firebase CLI is installed: $firebaseVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Firebase CLI not found. Installing..." -ForegroundColor Red
    Write-Host "Please run: npm install -g firebase-tools" -ForegroundColor Cyan
    exit 1
}

Write-Host ""

# Check if FlutterFire CLI is installed
Write-Host "Step 2: Checking FlutterFire CLI..." -ForegroundColor Yellow
try {
    $flutterfireVersion = flutterfire --version
    Write-Host "✅ FlutterFire CLI is installed" -ForegroundColor Green
} catch {
    Write-Host "❌ FlutterFire CLI not found. Installing..." -ForegroundColor Red
    dart pub global activate flutterfire_cli
}

Write-Host ""

# Login to Firebase
Write-Host "Step 3: Firebase Login" -ForegroundColor Yellow
Write-Host "Opening browser for Firebase login..." -ForegroundColor Cyan
firebase login

Write-Host ""

# Configure FlutterFire
Write-Host "Step 4: Configuring FlutterFire" -ForegroundColor Yellow
Write-Host "This will create firebase_options.dart and configure all platforms" -ForegroundColor Cyan
flutterfire configure

Write-Host ""

# Get dependencies
Write-Host "Step 5: Getting Flutter dependencies" -ForegroundColor Yellow
flutter pub get

Write-Host ""

Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Go to Firebase Console: https://console.firebase.google.com/" -ForegroundColor Cyan
Write-Host "2. Select your project" -ForegroundColor Cyan
Write-Host "3. Enable Firestore Database (Build → Firestore Database → Create Database)" -ForegroundColor Cyan
Write-Host "4. Choose 'Start in test mode'" -ForegroundColor Cyan
Write-Host "5. Select region: asia-south1 (Mumbai)" -ForegroundColor Cyan
Write-Host "6. Update your main.dart file (see FIREBASE_INTEGRATION_COMPLETE.md)" -ForegroundColor Cyan
Write-Host "7. Run your app: flutter run -d windows" -ForegroundColor Cyan
Write-Host ""
Write-Host "📚 Documentation: FIREBASE_INTEGRATION_COMPLETE.md" -ForegroundColor Yellow
Write-Host "📚 Detailed Setup: FIREBASE_SETUP.md" -ForegroundColor Yellow
