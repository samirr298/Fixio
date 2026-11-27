import 'package:flutter/material.dart';

enum BookingManageStatus {
  confirmed,
  rescheduled,
  cancelled,
}

class RescheduleCancelBookingModel {
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

  BookingManageStatus status;
  String? rescheduleReason;
  String? cancellationReason;
  String? cancellationNotes;
  DateTime? lastUpdated;

  RescheduleCancelBookingModel({
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
    this.status = BookingManageStatus.confirmed,
    this.rescheduleReason,
    this.cancellationReason,
    this.cancellationNotes,
    this.lastUpdated,
  });

  RescheduleCancelBookingModel copyWith({
    DateTime? date,
    String? timeSlot,
    BookingManageStatus? status,
    String? rescheduleReason,
    String? cancellationReason,
    String? cancellationNotes,
    DateTime? lastUpdated,
  }) {
    return RescheduleCancelBookingModel(
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
      status: status ?? this.status,
      rescheduleReason: rescheduleReason ?? this.rescheduleReason,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      cancellationNotes: cancellationNotes ?? this.cancellationNotes,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

// Initial active appointment for Agrim Shrestha
RescheduleCancelBookingModel getAgrimActiveBooking() {
  final now = DateTime.now();
  return RescheduleCancelBookingModel(
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
    status: BookingManageStatus.confirmed,
  );
}
