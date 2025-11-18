# UrbanIssue Flutter App

A Flutter mobile application for the Smart Urban Issue Reporting System. This app allows users to report, track, and manage urban issues in their community.

## Features

- 🔐 User Authentication (Login/Register)
- 📍 Report Issues with Location and Photos
- 📊 Dashboard with Statistics and Charts
- 🏢 Department Management View
- 🔔 Real-time Issue Tracking
- 📱 Beautiful Material Design UI

## Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Node.js backend server running (see main project README)
- Android Studio / Xcode for mobile development
- Android SDK / iOS development tools

## Installation

1. **Navigate to the Flutter app directory:**
   ```bash
   cd flutter_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Update API Base URL:**
   
   Open `lib/services/api_service.dart` and update the `baseUrl` constant:
   
   - For Android Emulator: `http://10.0.2.2:3000/api`
   - For iOS Simulator: `http://localhost:3000/api`
   - For Physical Device: `http://YOUR_COMPUTER_IP:3000/api` (e.g., `http://192.168.1.100:3000/api`)

4. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/                   # Data models
│   │   ├── user_model.dart
│   │   └── issue_model.dart
│   ├── providers/                # State management
│   │   ├── auth_provider.dart
│   │   └── issue_provider.dart
│   ├── screens/                  # UI Screens
│   │   ├── splash_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── home/
│   │   │   ├── landing_screen.dart
│   │   │   └── home_screen.dart
│   │   ├── report/
│   │   │   └── report_issue_screen.dart
│   │   ├── dashboard/
│   │   │   ├── dashboard_screen.dart
│   │   │   └── issue_detail_screen.dart
│   │   └── departments/
│   │       └── departments_screen.dart
│   └── services/                 # API services
│       └── api_service.dart
├── pubspec.yaml                  # Dependencies
└── README.md
```

## Dependencies

- **provider** - State management
- **http** - HTTP requests
- **shared_preferences** - Local storage
- **geolocator** - Location services
- **geocoding** - Address geocoding
- **image_picker** - Image selection
- **fl_chart** - Charts and graphs
- **google_fonts** - Custom fonts

## Backend Connection

The Flutter app connects to the Node.js/Express backend API. Make sure:

1. The backend server is running on port 3000
2. MongoDB is connected and running
3. CORS is enabled in the backend (already configured)
4. The API base URL in `api_service.dart` matches your setup

## Features in Detail

### Authentication
- User registration with email, name, and password
- Secure login with JWT token storage
- Automatic token refresh and validation

### Issue Reporting
- Select issue type (Sanitation, Roads, Water, Safety, Other)
- Add detailed description
- Capture current location using GPS
- Upload multiple photos
- Submit issues to backend

### Dashboard
- View statistics (Pending, In Progress, Resolved, Total)
- Interactive charts (Pie chart for types, Bar chart for priorities)
- Filter issues by status, type, and priority
- View recent issues list
- Tap to view issue details

### Issue Management
- View detailed issue information
- Update issue status and priority
- Add resolution notes
- Track issue progress

### Departments
- View department performance
- See active and resolved issues per department
- Efficiency metrics

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### Connection Issues
- Ensure backend server is running
- Check API base URL matches your setup
- Verify CORS settings in backend
- Check network connectivity

### Location Permissions
- Android: Add location permissions in `AndroidManifest.xml`
- iOS: Add location permissions in `Info.plist`

### Image Upload
- Currently, image paths are stored but not uploaded to server
- You'll need to implement multipart file upload in `api_service.dart`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License - see main project README for details

## Support

For issues and questions, please open an issue in the main repository.

