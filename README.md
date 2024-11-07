Here’s a `README.md` file that you can use as a starting point for your project. This template includes sections for project overview, setup, usage, folder structure, and other details. You can customize it further based on your specific needs and the features of your project.

---

# DealsDray Flutter App

Here is the video link to view about the project:- https://drive.google.com/file/d/1ghf3lOWhbtoPFGHZQR2z23Y6jB5Vbg3C/view?usp=drive_link

This is a Flutter application developed for **DealsDray**, featuring user authentication, OTP verification, registration with referral, and product retrieval from a backend API. The project follows a modular architecture with a separation of concerns between business logic and UI components.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- **OTP Authentication**: Request OTP for phone number verification and validate the received OTP.
- **User Registration**: Register new users with a referral code and password.
- **Product Retrieval**: Fetch and display products on the home screen.
- **Device Management**: Collect and send device information to the backend.

## Project Structure
Here’s an overview of the primary folders and files in the project:

```
lib/
├── bloc/                    # Contains BLoC classes for state management
│   ├── auth_bloc/           # Authentication BLoC files
│   ├── home_bloc/           # Home BLoC files
│   └── otp_sending_bloc/    # OTP sending BLoC files
├── Repositories/            # API repositories
│   ├── auth_repository.dart
│   ├── api_repository.dart
│   └── otp_repository.dart
├── view/                    # UI screens
│   ├── home_screen/         # Home screen and related components
│   ├── Initial_screen/      # Initial app entry screen
│   ├── registration_screen/ # Registration screen
│   └── splash_screen.dart   # Splash screen on app start
├── app.dart                 # Main app widget and router configuration
└── main.dart                # Entry point of the application
```

## Requirements
- **Flutter**: Version 3.0 or higher.
- **Dart**: Version 2.17 or higher.
- Backend API for authentication and data retrieval.

## Setup
1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/dealsdray-flutter-app.git
   cd dealsdray-flutter-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Update API URLs**:
   Ensure that the API URLs in the repository files (e.g., `otp_repository.dart`, `auth_repository.dart`) are correctly set to the backend endpoints provided in your documentation.

4. **Run the app**:
   Start the application on an emulator or a connected device.
   ```bash
   flutter run
   ```

## Usage
This application utilizes several screens and modules:

1. **Splash Screen**: Displays the splash screen on app launch.
2. **Phone Number Screen**: Requests the user's phone number and device information.
3. **OTP Screen**: Sends an OTP to the phone number provided and verifies the entered OTP.
4. **Registration Screen**: If OTP verification fails, the app redirects to the registration screen.
5. **Home Screen**: Fetches and displays products.

## API Documentation
The app communicates with the following API endpoints:

1. **Device Info** - Register device information:
   - Endpoint: `POST http://devapiv4.dealsdray.com/api/v2/user/device/add`

2. **OTP Request** - Request an OTP for authentication:
   - Endpoint: `POST http://devapiv4.dealsdray.com/api/v2/user/otp`

3. **OTP Verification** - Verify the received OTP:
   - Endpoint: `POST http://devapiv4.dealsdray.com/api/v2/user/otp/verification`

4. **User Registration** - Register a new user with referral:
   - Endpoint: `POST http://devapiv4.dealsdray.com/api/v2/user/email/referral`

5. **Product Fetching** - Retrieve products for the home screen:
   - Endpoint: `GET http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice`

For more details, see the full API documentation [here](https://documenter.getpostman.com/view/25104166/2sA3QmEvCV).

## Contributing
Contributions are welcome! Please follow these steps:
1. **Fork** the repository.
2. **Create a branch** for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. **Commit your changes**.
4. **Push** to your branch:
   ```bash
   git push origin feature-name
   ```
5. **Create a Pull Request**.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
