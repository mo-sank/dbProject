import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'providers/user_provider.dart';
import 'providers/budget_provider.dart';
import 'providers/lesson_provider.dart';
import 'providers/language_provider.dart';
import 'providers/scam_alert_provider.dart';
import 'services/firebase_config.dart';
import 'services/firebase_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const FinPathApp());
}

class FinPathApp extends StatelessWidget {
  const FinPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseService>(create: (_) => FirebaseService()),
        ChangeNotifierProxyProvider<FirebaseService, LanguageProvider>(
          create: (_) => LanguageProvider(),
          update: (_, firebaseService, languageProvider) {
            languageProvider!.setFirebaseService(firebaseService);
            return languageProvider;
          },
        ),
        ChangeNotifierProxyProvider<FirebaseService, UserProvider>(
          create: (_) => UserProvider(),
          update: (_, firebaseService, userProvider) {
            userProvider!.setFirebaseService(firebaseService);
            return userProvider;
          },
        ),
        ChangeNotifierProxyProvider<FirebaseService, BudgetProvider>(
          create: (_) => BudgetProvider(),
          update: (_, firebaseService, budgetProvider) {
            budgetProvider!.setFirebaseService(firebaseService);
            return budgetProvider;
          },
        ),
        ChangeNotifierProxyProvider<FirebaseService, LessonProvider>(
          create: (_) => LessonProvider(),
          update: (_, firebaseService, lessonProvider) {
            lessonProvider!.setFirebaseService(firebaseService);
            return lessonProvider;
          },
        ),
        ChangeNotifierProxyProvider<FirebaseService, ScamAlertProvider>(
          create: (_) => ScamAlertProvider(),
          update: (_, firebaseService, scamAlertProvider) {
            scamAlertProvider!.setFirebaseService(firebaseService);
            return scamAlertProvider;
          },
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'FinPath',
            debugShowCheckedModeBanner: false,
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('fr'), // French
              Locale('de'), // German
              Locale('it'), // Italian
              Locale('pt'), // Portuguese
              Locale('zh'), // Chinese
              Locale('ar'), // Arabic
              Locale('hi'), // Hindi
              Locale('ru'), // Russian
              Locale('ja'), // Japanese
              Locale('ko'), // Korean
              Locale('tr'), // Turkish
              Locale('pl'), // Polish
              Locale('nl'), // Dutch
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6C63FF),
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

