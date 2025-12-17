import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TrustLedgerApp());
}

class TrustLedgerApp extends StatelessWidget {
  const TrustLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        primaryColor: const Color(0xFF4C6FFF),
        cardColor: const Color(0xFF141B2D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4C6FFF),
          secondary: Color(0xFF00D9B1),
          surface: Color(0xFF141B2D),
          background: Color(0xFF0A0E1A),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
