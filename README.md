# MyMedBuddy

MyMedBuddy is a Flutter-based health companion app that helps users manage medications, appointments, health logs, and personal preferences. The app features onboarding, persistent user data, dark mode, notifications, and a modern, user-friendly interface.

---

## Features

- **Welcome & Onboarding**
  - Modern welcome screen with Login/Sign Up options.
  - Onboarding form collects user name, age, and medical condition.
  - User data is saved and auto-fills the profile page.

- **Home Dashboard**
  - Personalized greeting using the user’s name.
  - Quick navigation grid to Medications, Appointments, Health Logs, Profile, and Health Tips.

- **Medications**
  - Add, view, and delete medication schedules.
  - Data managed with Provider for state management.

- **Appointments**
  - Add, view, and delete health appointments.
  - Persistent storage using Provider and SharedPreferences.

- **Health Logs**
  - Add, view, and delete daily health logs.
  - Persistent storage using Provider and SharedPreferences.

- **Profile**
  - Auto-filled with user details from onboarding.
  - Read-only by default; tap Edit to update details.
  - Preferences section: Dark Mode toggle, Notifications toggle, Daily Log Reminder time picker.

- **Health Tips**
  - Fetches and displays real-time health tips from an API.
  - Shows loading spinner and error messages as needed.

- **Persistent Preferences**
  - All user data and preferences (theme, notifications, reminders) are saved using SharedPreferences and persist across app restarts.

- **Dynamic Dark Mode**
  - Toggle dark mode in the profile; the app theme updates instantly.

---

## App Structure

```
lib/
  main.dart                # App entry point, theme, and routing
  models/                  # Data models (medication, appointment, log, etc.)
  providers/               # Provider classes for state management
  screens/
    welcome_screen.dart    # Welcome/Login/Sign Up screen
    onboarding_screen.dart # Onboarding form
    home_screen.dart       # Dashboard
    medication_screen.dart # Medications feature
    appointments_screen.dart # Appointments feature
    health_logs_screen.dart  # Health logs feature
    profile_screen.dart      # Profile and preferences
    health_tips_screen.dart  # Health tips (API)
  services/
    shared_prefs_service.dart # SharedPreferences helper
    api_service.dart          # API calls for health tips
test/
  widget_test.dart          # Widget tests
```

---

## Packages Used

- **provider**: State management for medications, appointments, and logs.
- **shared_preferences**: Persistent storage for user data and preferences.
- **uuid**: Generating unique IDs for medications, logs, etc.
- **http**: Fetching health tips from an external API.
- **flutter/material.dart**: Core Flutter UI components.

---

## How to Run (Mount) the App

1. **Clone the Repository**
   ```sh
   git clone [your-repo-url]
   cd mymedbuddyapp
   ```

2. **Install Dependencies**
   ```sh
   flutter pub get
   ```

3. **Enable Developer Mode (Windows)**
   - Open Run (`Win + R`), type:  
     `start ms-settings:developers`
   - Enable **Developer Mode**.

4. **Run the App**
   - For Android emulator or device:
     ```sh
     flutter run
     ```
   - For web:
     ```sh
     flutter run -d chrome
     ```
   - For Windows desktop:
     ```sh
     flutter run -d windows
     ```

5. **Troubleshooting**
   - If you see errors about disk space, free up space on your drive.
   - If you see errors about symlinks, ensure Developer Mode is enabled.
   - If you see NDK version errors, install the required NDK version via Android Studio’s SDK Manager.



## How to Use the App

1. **Launch the app.**
2. **Welcome Screen:** Choose Login or Sign Up.
3. **Onboarding:** Enter your name, age, and condition.
4. **Home:** Navigate to Medications, Appointments, Health Logs, Profile, or Health Tips.
5. **Profile:** View and edit your details, toggle dark mode, notifications, and set reminders.
6. **All data and preferences are saved and persist across app restarts.**


