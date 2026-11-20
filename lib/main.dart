import 'package:fixio/view/price_estimate/price_estimate_screen.dart';
import 'package:flutter/material.dart';
import 'view/technician_profile/technician_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066FF)),
        useMaterial3: true,
      ),
      home: const PriceEstimateScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
