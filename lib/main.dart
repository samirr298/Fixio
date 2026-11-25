import 'package:flutter/material.dart';
import 'package:fixio/view/booking/reschedule_cancel_booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {b  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066FF)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const RescheduleCancelBookingScreen(),
    );
  }
}
