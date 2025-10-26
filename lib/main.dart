import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/routes.dart';
import 'package:evently_app/ui/common/AppSharedPreferences.dart';
import 'package:evently_app/ui/design/design.dart';
import 'package:evently_app/ui/providers/AppAuthProvider.dart';
import 'package:evently_app/ui/providers/LanguageProvider.dart';
import 'package:evently_app/ui/providers/ThemeProvider.dart';
import 'package:evently_app/ui/screens/addEvent/AddEventScreen.dart';
import 'package:evently_app/ui/screens/home/EditEventScreen.dart';
import 'package:evently_app/ui/screens/home/HomeScreen.dart';
import 'package:evently_app/ui/screens/login/LoginScreen.dart';
import 'package:evently_app/ui/screens/onBoarding/OnBoarding.dart';
import 'package:evently_app/ui/screens/register/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/model/event.dart';
import 'ui/screens/home/EventDetailsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppSharedPreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: provider.getSelectedThemeMode(),
      initialRoute:
      authProvider.isLoggedInBefore()? AppRoutes.HomeScreen.name : AppRoutes.LoginScreen.name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.RegisterScreen.name : (context) => RegisterScreen(),
        AppRoutes.LoginScreen.name : (context) => LoginScreen(),
        AppRoutes.HomeScreen.name : (context) => HomeScreen(),
        AppRoutes.AddEvent.name : (context) => AddEventScreen(),
        AppRoutes.EditEventScreen.name: (context) {
          final event = ModalRoute.of(context)!.settings.arguments as Event;
          return EditEventScreen(eventToEdit: event);
        },

        AppRoutes.EventDetailsScreen.name: (context) {
          final event = ModalRoute.of(context)!.settings.arguments as Event;
          return EventDetailsScreen(event: event);
        }
         },
    );
  }
}