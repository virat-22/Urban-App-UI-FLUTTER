# Project Structure

## Overview
This is a **Flutter-only mobile application** with a Node.js/Express backend API. All HTML/web frontend has been removed.

## Directory Structure

```
urban-issue-app/
│
├── flutter_app/                  # Flutter Mobile App (iOS & Android)
│   ├── lib/
│   │   ├── main.dart            # App entry point
│   │   ├── models/              # Data models
│   │   │   ├── user_model.dart
│   │   │   └── issue_model.dart
│   │   ├── providers/           # State management (Provider)
│   │   │   ├── auth_provider.dart
│   │   │   └── issue_provider.dart
│   │   ├── screens/             # UI Screens
│   │   │   ├── splash_screen.dart
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   ├── home/
│   │   │   │   ├── landing_screen.dart
│   │   │   │   └── home_screen.dart
│   │   │   ├── report/
│   │   │   │   ├── report_issue_screen.dart
│   │   │   │   └── issue_success_screen.dart
│   │   │   ├── dashboard/
│   │   │   │   ├── dashboard_screen.dart
│   │   │   │   └── issue_detail_screen.dart
│   │   │   └── departments/
│   │   │       └── departments_screen.dart
│   │   └── services/            # API services
│   │       └── api_service.dart
│   ├── android/                 # Android configuration
│   ├── ios/                     # iOS configuration
│   ├── pubspec.yaml            # Flutter dependencies
│   └── README.md               # Flutter app documentation
│
├── models/                      # Backend: MongoDB Models
│   ├── User.js
│   └── Issue.js
│
├── routes/                      # Backend: API Routes
│   ├── auth.js                 # Authentication routes
│   ├── issues.js               # Issue management routes
│   └── users.js                # User routes
│
├── public/                      # Backend: Static files
│   └── images/
│       └── uploads/            # Uploaded issue images
│
├── server.js                    # Express server (API only)
├── package.json                 # Node.js dependencies
├── README.md                    # Main project documentation
└── FLUTTER_MIGRATION.md         # Migration guide
```

## Technology Stack

### Frontend (Flutter)
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **HTTP Client**: http package
- **Charts**: fl_chart
- **Location**: geolocator, geocoding
- **Storage**: shared_preferences
- **Image Picker**: image_picker

### Backend (Node.js)
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB (Mongoose)
- **Authentication**: JWT (jsonwebtoken)
- **File Upload**: Multer
- **Validation**: express-validator

## Key Features

### Mobile App (Flutter)
1. **Authentication**
   - User registration
   - Login with JWT
   - Auto-login on app start

2. **Issue Reporting**
   - Select issue type
   - Add description
   - Capture GPS location
   - Upload photos
   - Submit to backend

3. **Dashboard**
   - Statistics cards
   - Interactive charts
   - Issue filtering
   - Issue list view

4. **Issue Management**
   - View issue details
   - Update status/priority
   - Add resolution notes

5. **Departments**
   - View department performance
   - Active/resolved issue counts
   - Efficiency metrics

### Backend API
1. **RESTful API** - All endpoints under `/api`
2. **Authentication** - JWT-based auth
3. **File Upload** - Image upload support
4. **Database** - MongoDB with Mongoose
5. **CORS** - Enabled for mobile app access

## Getting Started

### 1. Backend Setup
```bash
npm install
npm start
```

### 2. Flutter App Setup
```bash
cd flutter_app
flutter pub get
flutter run
```

See individual README files for detailed instructions.

## No Web/HTML Frontend

This project **does not include** any HTML/web frontend. All user interfaces are built with Flutter for native mobile experience.

## API Base URL Configuration

Update `flutter_app/lib/services/api_service.dart`:
- Android Emulator: `http://10.0.2.2:3000/api`
- iOS Simulator: `http://localhost:3000/api`
- Physical Device: `http://YOUR_COMPUTER_IP:3000/api`
