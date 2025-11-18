# Smart Urban Issue Reporting System

A complete mobile application for reporting, tracking, and resolving urban issues. Built with Flutter for iOS and Android, with a Node.js/Express backend API.

## Features
- 📱 **Flutter Mobile App** - Native iOS and Android app
- 🔐 **User Authentication** - Secure login/register with JWT
- 📍 **Issue Reporting** - Report issues with GPS location and photos
- 📊 **Dashboard** - Statistics, charts, and issue management
- 🏢 **Department Management** - Track department performance
- 🔔 **Real-time Updates** - Track issue status changes
- 🗄️ **MongoDB Database** - Scalable data storage

## Project Structure
```
urban-issue-app/
│
├── models/              # MongoDB models
│   ├── User.js
│   └── Issue.js
│
├── routes/              # API routes
│   ├── auth.js
│   ├── issues.js
│   └── users.js
│
├── public/
│   └── images/          # Uploaded issue images
│
├── flutter_app/         # Flutter mobile app
│   └── ...
│
├── server.js            # Express server
├── package.json
└── README.md
```

## Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (v14 or higher)
- [MongoDB](https://www.mongodb.com/) (local or cloud instance)
- [Flutter](https://flutter.dev/) (for mobile app)

### Installation

1. **Backend Setup:**
   ```bash
   npm install
   ```

2. **Environment Variables:**
   Create a `.env` file:
   ```
   MONGODB_URI=mongodb://localhost:27017/urban-issue-app
   JWT_SECRET=your-secret-key-change-in-production
   PORT=3000
   ```

3. **Start the Server:**
   ```bash
   npm start
   ```
   The API will be available at `http://localhost:3000/api`

4. **Flutter App Setup:**
   ```bash
   cd flutter_app
   flutter pub get
   ```
   
   See `flutter_app/README.md` for detailed Flutter setup instructions.

5. **Run Flutter App:**
   ```bash
   flutter run
   ```
   
   **Important:** Update the API base URL in `flutter_app/lib/services/api_service.dart`:
   - Android Emulator: `http://10.0.2.2:3000/api`
   - iOS Simulator: `http://localhost:3000/api`
   - Physical Device: `http://YOUR_COMPUTER_IP:3000/api`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Issues
- `GET /api/issues` - Get all issues (with filters)
- `GET /api/issues/stats` - Get dashboard statistics
- `GET /api/issues/:id` - Get single issue
- `POST /api/issues` - Create new issue
- `PUT /api/issues/:id` - Update issue
- `DELETE /api/issues/:id` - Delete issue

### Users
- `GET /api/users/me` - Get current user profile
- `GET /api/users/me/issues` - Get user's issues

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- **Urban Issue Reporting System Team**

## Acknowledgments

- Built with Flutter and Node.js
- Uses MongoDB for data storage
- Material Design for UI components 