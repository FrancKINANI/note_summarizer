import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline AI App',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Use our custom dark theme
      home: const HomeScreen(),
    );
  }
}
