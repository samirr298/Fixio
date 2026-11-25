import 'package:flutter/material.dart';

import '../../model/reschedule_cancel_booking_model.dart';

class CancelBookingSheet extends StatefulWidget {
  final RescheduleCancelBookingModel booking;
  final Function(RescheduleCancelBookingModel cancelledBooking) onBookingCancelled;

  const CancelBookingSheet({
    super.key,
    required this.booking,
    required this.onBookingCancelled,
  });

  static Future<void> show(
    BuildContext context, {
    required RescheduleCancelBookingModel booking,
    required Function(RescheduleCancelBookingModel) onBookingCancelled,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CancelBookingSheet(
        booking: booking,
        onBookingCancelled: onBookingCancelled,
      ),
    );
  }

  @override
  State<CancelBookingSheet> createState() => _CancelBookingSheetState();
}

class _CancelBookingSheetState extends State<CancelBookingSheet> {
  String? selectedReason;
  final TextEditingController notesController = TextEditingController();
  String? errorMessage;
  bool simulateError = false; // Toggle for Acceptance Criteria 5 testing
  bool isSubmitting = false;

  final List<String> cancelReasons = [
    'Schedule Conflict with Student Classes / Exams',
    'Issue Resolved / Repair No Longer Needed',
    'Found Alternative Service / High Cost',
    'Booked by Mistake',
    'Specialist Delayed or Requested Change',
    'Other (Specify below)',
  ];

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void _handleCancel() {
    setState(() {
      errorMessage = null;
    });

    // Validation (Acceptance Criteria 3)
    if (selectedReason == null || selectedReason!.isEmpty) {
      setState(() {
        errorMessage = 'Please select a reason for cancelling your booking.';
      });
      return;
    }

    if (selectedReason == 'Other (Specify below)' &&
        notesController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please write a brief explanation for cancelling.';
      });
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        isSubmitting = false;
      });

      // Simulation Error Handling (Acceptance Criteria 5)
      if (simulateError) {
        Navigator.pop(context); // Close sheet
        _showErrorDialog(
          'Cancellation Failed',
          'Technician Navam Shrestha has already arrived at Downtown Apt 4B. In-app cancellation is locked. Please contact Fixio Support immediately for emergency agent assistance.',
        );
        return;
      }

      // Record Saved & Confirmation (Acceptance Criteria 4)
      final String finalReason = selectedReason == 'Other (Specify below)'
          ? notesController.text.trim()
          : selectedReason!;

      final cancelledBooking = widget.booking.copyWith(
        status: BookingManageStatus.cancelled,
        cancellationReason: finalReason,
        cancellationNotes: notesController.text.trim(),
        lastUpdated: DateTime.now(),
      );

      widget.onBookingCancelled(cancelledBooking);
      Navigator.pop(context); // Close sheet
      _showSuccessConfirmation(cancelledBooking);
    });
  }

  void _showSuccessConfirmation(RescheduleCancelBookingModel cancelled) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cancel_rounded,
                  color: Color(0xFFEF4444),
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Booking Cancelled',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Booking #${cancelled.bookingId} has been cancelled successfully for ${cancelled.customerName}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF0066FF), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Refund Status',
                            style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                          ),
                          Text(
                            'Full refund of NPR ${cancelled.estimatedTotalNpr.toInt()} processed',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Return to Appointment',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connecting to customer support agent at +977 9801234567...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Call Support', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Row(
                children: [
                  Icon(Icons.event_busy_outlined, color: Color(0xFFDC2626), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Cancel Booking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Booking #${widget.booking.bookingId} • ${widget.booking.serviceTitle}',
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),

              // Policy Info Card matching Screen 11
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFF0066FF), size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Cancellation Policy: Free cancellation up to 1 hour before scheduled arrival. No hidden fees or lock-ins.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1E3A8A),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Please select a reason for cancelling *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),

              // Reasons List
              Column(
                children: cancelReasons.map((reason) {
                  final isSelected = selectedReason == reason;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedReason = reason;
                        errorMessage = null;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFEF2F2) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              reason,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? const Color(0xFF991B1B) : const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              if (selectedReason == 'Other (Specify below)') ...[
                const SizedBox(height: 10),
                TextField(
                  controller: notesController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Describe your reason...',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                  ),
                ),
              ],

              // Inline Validation Error (Acceptance Criteria 3)
              if (errorMessage != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFCA5A5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Color(0xFFDC2626), fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Simulation switch for Criteria 5
              Row(
                children: [
                  const Icon(Icons.bug_report, color: Color(0xFFD97706), size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Simulate Failure (Criteria 5)',
                      style: TextStyle(fontSize: 12, color: Color(0xFFB45309), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Switch(
                    value: simulateError,
                    activeColor: const Color(0xFFD97706),
                    onChanged: (val) {
                      setState(() {
                        simulateError = val;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Keep Booking',
                        style: TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: isSubmitting ? null : _handleCancel,
                      child: isSubmitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'Confirm Cancel',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
