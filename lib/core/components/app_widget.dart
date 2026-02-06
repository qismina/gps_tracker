import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../views/home_screen.dart';

class GPSTrackerApp extends StatelessWidget {
  const GPSTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walking Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}