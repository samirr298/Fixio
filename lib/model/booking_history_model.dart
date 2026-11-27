import 'package:flutter/material.dart';

enum HistoryBookingStatus {
  upcoming,
  rescheduled,
  completed,
  cancelled,
}

class BookingHistoryModel {
  final String bookingId;
  final String customerName;
  final String customerRole;
  final String serviceTitle;
  final String serviceSubtitle;
  final String category;
  final String specialistName;
  final String specialistTitle;
  final double specialistRating;
  final bool isVerifiedPro;
  final String tagLabel;
  final Color tagColor;

  DateTime date;
  String timeSlot;
  final String serviceAddress;
  final String accessNote;
  final double estimatedTotalNpr;
  final String paymentMethod;

  HistoryBookingStatus status;
  double? userRating;
  String? userReviewText;
  String? cancellationReason;
  String? rescheduleReason;
  DateTime? completedAt;

  BookingHistoryModel({
    required this.bookingId,
    required this.customerName,
    required this.customerRole,
    required this.serviceTitle,
    required this.serviceSubtitle,
    required this.category,
    required this.specialistName,
    required this.specialistTitle,
    required this.specialistRating,
    this.isVerifiedPro = true,
    required this.tagLabel,
    required this.tagColor,
    required this.date,
    required this.timeSlot,
    required this.serviceAddress,
    required this.accessNote,
    required this.estimatedTotalNpr,
    this.paymentMethod = 'Cash on Completion',
    required this.status,
    this.userRating,
    this.userReviewText,
    this.cancellationReason,
    this.rescheduleReason,
    this.completedAt,
  });

  BookingHistoryModel copyWith({
    HistoryBookingStatus? status,
    double? userRating,
    String? userReviewText,
    DateTime? date,
    String? timeSlot,
    String? rescheduleReason,
    String? cancellationReason,
  }) {
    return BookingHistoryModel(
      bookingId: bookingId,
      customerName: customerName,
      customerRole: customerRole,
      serviceTitle: serviceTitle,
      serviceSubtitle: serviceSubtitle,
      category: category,
      specialistName: specialistName,
      specialistTitle: specialistTitle,
      specialistRating: specialistRating,
      isVerifiedPro: isVerifiedPro,
      tagLabel: tagLabel,
      tagColor: tagColor,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      serviceAddress: serviceAddress,
      accessNote: accessNote,
      estimatedTotalNpr: estimatedTotalNpr,
      paymentMethod: paymentMethod,
      status: status ?? this.status,
      userRating: userRating ?? this.userRating,
      userReviewText: userReviewText ?? this.userReviewText,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      rescheduleReason: rescheduleReason ?? this.rescheduleReason,
      completedAt: completedAt ?? completedAt,
    );
  }
}

// Mock dataset representing past and upcoming booking history for Agrim Shrestha
List<BookingHistoryModel> getAgrimBookingHistory() {
  final now = DateTime.now();

  return [
    // 1. Upcoming active service
    BookingHistoryModel(
      bookingId: 'FIX-89201',
      customerName: 'Agrim Shrestha',
      customerRole: 'Student & Customer',
      serviceTitle: 'Pipe Leak Repair',
      serviceSubtitle: 'Diagnostic & Rapid Sealing',
      category: 'Plumbing',
      specialistName: 'Navam Shrestha',
      specialistTitle: 'Master Plumber',
      specialistRating: 4.9,
      isVerifiedPro: true,
      tagLabel: 'Emergency',
      tagColor: const Color(0xFF10B981),
      date: now.add(const Duration(hours: 4)),
      timeSlot: '02:30 PM',
      serviceAddress: 'Downtown Apt 4B, Kathmandu',
      accessNote: '4th Floor via elevator',
      estimatedTotalNpr: 1250.0,
      status: HistoryBookingStatus.upcoming,
    ),

    // 2. Completed service 1
    BookingHistoryModel(
      bookingId: 'FIX-88104',
      customerName: 'Agrim Shrestha',
      customerRole: 'Student & Customer',
      serviceTitle: 'AC Filter & Deep Clean',
      serviceSubtitle: 'Routine Maintenance & Sanitization',
      category: 'HVAC',
      specialistName: 'Bikram Thapa',
      specialistTitle: 'HVAC Senior Specialist',
      specialistRating: 4.8,
      isVerifiedPro: true,
      tagLabel: 'Routine',
      tagColor: const Color(0xFF0066FF),
      date: now.subtract(const Duration(days: 12)),
      timeSlot: '11:00 AM',
      serviceAddress: 'Downtown Apt 4B, Kathmandu',
      accessNote: 'Call on arrival',
      estimatedTotalNpr: 1800.0,
      status: HistoryBookingStatus.completed,
      userRating: 5.0,
      userReviewText: 'Excellent service! Bikram cleaned both indoor AC units fast.',
      completedAt: now.subtract(const Duration(days: 12)),
    ),

    // 3. Completed service 2
    BookingHistoryModel(
      bookingId: 'FIX-87052',
      customerName: 'Agrim Shrestha',
      customerRole: 'Student & Customer',
      serviceTitle: 'Electrical Socket Repair',
      serviceSubtitle: 'Short Circuit Fix & Replacement',
      category: 'Electrical',
      specialistName: 'Sujit Maharjan',
      specialistTitle: 'Certified Electrician',
      specialistRating: 4.9,
      isVerifiedPro: true,
      tagLabel: 'Standard',
      tagColor: const Color(0xFF6366F1),
      date: now.subtract(const Duration(days: 28)),
      timeSlot: '04:00 PM',
      serviceAddress: 'Downtown Apt 4B, Kathmandu',
      accessNote: 'Main entrance gate',
      estimatedTotalNpr: 950.0,
      status: HistoryBookingStatus.completed,
      userRating: 4.5,
      userReviewText: 'Very professional worker. Resolved socket sparking issue safely.',
      completedAt: now.subtract(const Duration(days: 28)),
    ),

    // 4. Cancelled service
    BookingHistoryModel(
      bookingId: 'FIX-86910',
      customerName: 'Agrim Shrestha',
      customerRole: 'Student & Customer',
      serviceTitle: 'Water Heater Inspection',
      serviceSubtitle: 'Thermostat Diagnostic',
      category: 'Plumbing',
      specialistName: 'Rohan Shrestha',
      specialistTitle: 'Plumbing Technician',
      specialistRating: 4.7,
      isVerifiedPro: true,
      tagLabel: 'Routine',
      tagColor: const Color(0xFF0066FF),
      date: now.subtract(const Duration(days: 45)),
      timeSlot: '09:30 AM',
      serviceAddress: 'Downtown Apt 4B, Kathmandu',
      accessNote: 'Call student room 4B',
      estimatedTotalNpr: 1100.0,
      status: HistoryBookingStatus.cancelled,
      cancellationReason: 'Schedule Conflict with Student Exams',
    ),
  ];
}
