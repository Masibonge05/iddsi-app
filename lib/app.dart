import 'package:flutter/material.dart';
import 'personal_info.dart';
import 'welcome1.dart';
import 'welcome2.dart';
import 'welcome3.dart';
import 'welcome4.dart';
import 'welcome5.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'forgot_password_page.dart';
import 'testing_page.dart';
import 'chatbot.dart';
import 'framework.dart';
import 'search_page.dart';

class IDDSIApp extends StatelessWidget {
  final bool hasSeenWelcome;

  const IDDSIApp({super.key, required this.hasSeenWelcome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C7378),
          primary: const Color(0xFF1F41BB),
        ),
      ),
      initialRoute: hasSeenWelcome ? '/signin' : '/welcome1',
      routes: {
        '/': (context) => const IDDSIPersonalInfoPage(),
        '/welcome1': (context) => Welcome1(
              onNext: () {
                Navigator.pushNamed(context, '/welcome2');
              },
            ),
        '/welcome2': (context) => Welcome2(
              onNext: () {
                Navigator.pushNamed(context, '/welcome3');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome1');
              },
            ),
        '/welcome3': (context) => Welcome3(
              onNext: () {
                Navigator.pushNamed(context, '/welcome4');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome2');
              },
            ),
        '/welcome4': (context) => Welcome4(
              onNext: () {
                Navigator.pushNamed(context, '/welcome5');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome3');
              },
            ),
        '/welcome5': (context) => Welcome5(
              onNext: () {
                Navigator.pushNamed(context, '/signin');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome4');
              },
            ),
        '/signin': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgotPassword': (context) => const ForgotPasswordPage(),
        '/personalInfo': (context) => const IDDSIPersonalInfoPage(),
        '/framework': (context) => FrameworkPage(),
        '/testing': (context) => TestingPage(),
        '/chatbot': (context) => ChatbotPage(),
        '/search': (context) => SearchPage(),
        
      },
    );
  }
}