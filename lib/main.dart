// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/medication_provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/logs_provider.dart';
import 'screens/medication_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/health_logs_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/health_tips_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/shared_prefs_service.dart';

final ValueNotifier<bool> darkModeNotifier = ValueNotifier(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await SharedPrefsService.getDarkMode();
  darkModeNotifier.value = isDark;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => LogsProvider()),
      ],
      child: const MyMedBuddyApp(),
    ),
  );
}

class MyMedBuddyApp extends StatelessWidget {
  const MyMedBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkModeNotifier,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'MyMedBuddy',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: const Color(0xFFFDFDFD),
            fontFamily: 'Roboto',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.teal,
            colorScheme: ThemeData.dark().colorScheme.copyWith(
              secondary: Colors.teal,
            ),
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const WelcomeScreen(),
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/home': (context) => const HomeScreen(),
            '/medication': (context) => const MedicationScreen(),
            '/appointments': (context) => const AppointmentsScreen(),
            '/logs': (context) => const HealthLogsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/tips': (context) => const HealthTipsScreen(),
          },
        );
      },
    );
  }
}
