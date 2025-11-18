# Flutter Migration Guide

This document describes the conversion of the Urban Issue Reporting System from a web application to a Flutter mobile app.

## What Was Converted

### Backend (Unchanged)
- The Node.js/Express backend remains unchanged
- All API endpoints work the same way
- MongoDB database structure is the same
- The Flutter app consumes the existing REST API

### Frontend (Converted to Flutter)

#### Pages Converted:
1. **Landing Page** (`index.html`) → `landing_screen.dart`
2. **Login** (`login.html`) → `login_screen.dart`
3. **Register** (`register.html`) → `register_screen.dart`
4. **Report Issue** (`report.html`) → `report_issue_screen.dart`
5. **Dashboard** (`dashboard.html`) → `dashboard_screen.dart`
6. **Departments** (`departments.html`) → `departments_screen.dart`
7. **Issue Detail** (new) → `issue_detail_screen.dart`

#### Features Implemented:
- ✅ User authentication (login/register)
- ✅ Issue reporting with location and photos
- ✅ Dashboard with statistics and charts
- ✅ Issue filtering and management
- ✅ Department views
- ✅ State management with Provider
- ✅ API integration
- ✅ Local storage for tokens
- ✅ Material Design UI

## Architecture

### State Management
- **Provider** pattern for state management
- `AuthProvider` - handles authentication state
- `IssueProvider` - handles issue data and operations

### API Service
- Centralized API service in `lib/services/api_service.dart`
- Handles all HTTP requests to backend
- Manages authentication tokens
- Error handling

### Models
- `User` model - user data structure
- `Issue` model - issue data structure
- `DashboardStats` model - dashboard statistics

## Key Differences from Web Version

1. **Navigation**: Uses Flutter Navigator instead of page redirects
2. **State Management**: Provider instead of vanilla JavaScript
3. **UI Components**: Material Design widgets instead of Bootstrap
4. **Charts**: FL Chart library instead of Chart.js
5. **Location**: Native geolocator instead of Leaflet maps
6. **Storage**: SharedPreferences instead of localStorage

## File Structure Comparison

### Web App Structure:
```
/
├── index.html
├── login.html
├── register.html
├── report.html
├── dashboard.html
├── departments.html
├── public/
│   ├── js/
│   └── css/
└── server.js
```

### Flutter App Structure:
```
flutter_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── providers/
│   ├── screens/
│   └── services/
├── pubspec.yaml
└── README.md
```

## Running Both Versions

You can run both the web and Flutter versions simultaneously:

1. **Start Backend:**
   ```bash
   npm start
   ```

2. **Web Version:**
   - Open `http://localhost:3000` in browser

3. **Flutter Version:**
   ```bash
   cd flutter_app
   flutter run
   ```

Both will connect to the same backend API.

## Migration Benefits

1. **Native Performance**: Better performance on mobile devices
2. **Offline Support**: Can be extended with offline capabilities
3. **Native Features**: Access to device features (camera, GPS, etc.)
4. **Cross-Platform**: Single codebase for iOS and Android
5. **Better UX**: Native mobile UI/UX patterns

## Next Steps for Enhancement

1. **Image Upload**: Implement multipart file upload for photos
2. **Offline Mode**: Add offline issue reporting with sync
3. **Push Notifications**: Add push notifications for issue updates
4. **Maps Integration**: Add Google Maps for issue location visualization
5. **Biometric Auth**: Add fingerprint/face ID authentication
6. **Dark Mode**: Implement dark theme support

## Support

For issues or questions about the Flutter migration, please refer to:
- Flutter documentation: https://flutter.dev/docs
- Backend API documentation in main README
- Flutter app README in `flutter_app/README.md`

