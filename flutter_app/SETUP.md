# Flutter App Setup Guide

## Quick Start

1. **Install Flutter:**
   - Download from https://flutter.dev/docs/get-started/install
   - Follow platform-specific setup instructions

2. **Verify Installation:**
   ```bash
   flutter doctor
   ```

3. **Navigate to Flutter App:**
   ```bash
   cd flutter_app
   ```

4. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

5. **Configure API URL:**
   
   Edit `lib/services/api_service.dart` and update the `baseUrl`:
   
   ```dart
   static const String baseUrl = 'http://YOUR_BACKEND_URL/api';
   ```
   
   **Important URLs:**
   - Android Emulator: `http://10.0.2.2:3000/api`
   - iOS Simulator: `http://localhost:3000/api`
   - Physical Device: `http://YOUR_COMPUTER_IP:3000/api`
   
   To find your computer's IP:
   - Windows: `ipconfig` (look for IPv4 Address)
   - Mac/Linux: `ifconfig` or `ip addr`

6. **Start Backend Server:**
   
   In the main project directory:
   ```bash
   npm start
   ```

7. **Run Flutter App:**
   ```bash
   flutter run
   ```

## Platform-Specific Setup

### Android

1. Install Android Studio
2. Install Android SDK (API level 21 or higher)
3. Create an Android Virtual Device (AVD)
4. Enable USB debugging on physical device (if using)

### iOS (Mac only)

1. Install Xcode from App Store
2. Install CocoaPods: `sudo gem install cocoapods`
3. Run: `cd ios && pod install && cd ..`
4. Open iOS Simulator or connect physical device

## Testing

Run tests:
```bash
flutter test
```

## Building

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### "Unable to connect to backend"
- Ensure backend server is running
- Check API URL in `api_service.dart`
- Verify network connectivity
- Check firewall settings

### "Location permission denied"
- Android: Permissions are in `AndroidManifest.xml`
- iOS: Permissions are in `Info.plist`
- Grant permissions in device settings

### "Package not found"
- Run `flutter pub get`
- Check `pubspec.yaml` for correct package names

### Build Errors
- Run `flutter clean`
- Run `flutter pub get`
- Delete `build/` folder
- Try again

## Next Steps

1. Review the main README.md for backend setup
2. Ensure MongoDB is running
3. Test API endpoints with Postman or similar
4. Run the Flutter app and test all features

