import 'package:flutter/material.dart';

import '../../model/reschedule_cancel_booking_model.dart';
import 'cancel_booking_sheet.dart';
import 'reschedule_appointment_screen.dart';

class RescheduleCancelBookingScreen extends StatefulWidget {
  final RescheduleCancelBookingModel? initialBooking;

  const RescheduleCancelBookingScreen({
    super.key,
    this.initialBooking,
  });

  @override
  State<RescheduleCancelBookingScreen> createState() =>
      _RescheduleCancelBookingScreenState();
}

class _RescheduleCancelBookingScreenState
    extends State<RescheduleCancelBookingScreen> {
  late RescheduleCancelBookingModel booking;

  @override
  void initState() {
    super.initState();
    booking = widget.initialBooking ?? getAgrimActiveBooking();
  }

  void _updateBooking(RescheduleCancelBookingModel updated) {
    setState(() {
      booking = updated;
    });
  }

  String _getMonthName(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[date.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final bool isCancelled = booking.status == BookingManageStatus.cancelled;
    final bool isRescheduled = booking.status == BookingManageStatus.rescheduled;

    return Scaffold(
      backgroundColor: Colors.white,

      // App Bar - Matching Screen 11 Header
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Manage Appointment',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: const Text(
                  '3/3',
                  style: TextStyle(
                    color: Color(0xFF0066FF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Status Banner if Rescheduled or Cancelled
            if (isRescheduled) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF93C5FD)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.update, color: Color(0xFF0066FF), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Appointment Rescheduled',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E40AF),
                            ),
                          ),
                          Text(
                            'Reason: ${booking.rescheduleReason ?? "Updated schedule"}',
                            style: const TextStyle(fontSize: 11, color: Color(0xFF3B82F6)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (isCancelled) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.cancel_outlined, color: Color(0xFFDC2626), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Booking Cancelled',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF991B1B),
                            ),
                          ),
                          Text(
                            'Reason: ${booking.cancellationReason ?? "User request"}',
                            style: const TextStyle(fontSize: 11, color: Color(0xFFEF4444)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Customer Info Tag (Agrim Shrestha) - Criteria 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: const Color(0x1F0066FF),
                      child: const Icon(Icons.person, size: 16, color: Color(0xFF0066FF)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      booking.customerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Authorized',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF15803D),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'BOOKING SUMMARY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // MAIN SERVICE BOOKING SUMMARY CARD - Matching Screen 11
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 14,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.plumbing,
                          color: Color(0xFF0066FF),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    booking.serviceTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: booking.tagColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    booking.tagLabel,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: booking.tagColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              booking.serviceSubtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ),

                  // Assigned Specialist
                  _buildDetailRow(
                    icon: Icons.badge_outlined,
                    label: 'Assigned Specialist',
                    valueWidget: Row(
                      children: [
                        Text(
                          booking.specialistName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '• ${booking.specialistTitle}',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 2),
                        Text(
                          '${booking.specialistRating}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Date & Arrival Window
                  _buildDetailRow(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date & Arrival Window',
                    valueWidget: Text(
                      '${_getMonthName(booking.date)} ${booking.date.day} at ${booking.timeSlot}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0066FF),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Service Address
                  _buildDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Service Address',
                    valueWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'Access note: ${booking.accessNote}',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ),

                  // Estimated Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimated Total',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'NPR ${booking.estimatedTotalNpr.toInt()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const Text(
                            'Inspection included',
                            style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // PAYMENT METHOD CARD - Matching Screen 11
            const Text(
              'PAYMENT METHOD',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0066FF), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.payments_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Cash on Completion',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Default',
                              style: TextStyle(fontSize: 10, color: Color(0xFF0066FF), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          'Pay technician in cash after service',
                          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF0066FF),
                    size: 22,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Cancellation Policy Card - Matching Screen 11
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
                  Icon(
                    Icons.info_outline,
                    color: Color(0xFF0066FF),
                    size: 20,
                  ),
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

            const SizedBox(height: 28),

            // ACTION CONTROLS FOR RESCHEDULE OR CANCEL BOOKING
            const Text(
              'MANAGE APPOINTMENT CONTROLS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            if (!isCancelled) ...[
              // Reschedule Appointment Button (Primary Electric Blue)
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RescheduleAppointmentScreen(
                          booking: booking,
                          onBookingUpdated: _updateBooking,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_calendar_rounded, color: Colors.white, size: 20),
                  label: const Text(
                    'Reschedule Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Cancel Booking Button (Secondary Danger Action)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side: const BorderSide(color: Color(0xFFFCA5A5)),
                    backgroundColor: const Color(0xFFFEF2F2),
                  ),
                  onPressed: () {
                    CancelBookingSheet.show(
                      context,
                      booking: booking,
                      onBookingCancelled: _updateBooking,
                    );
                  },
                  icon: const Icon(Icons.cancel_outlined, color: Color(0xFFDC2626), size: 20),
                  label: const Text(
                    'Cancel Booking',
                    style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      booking = booking.copyWith(
                        status: BookingManageStatus.confirmed,
                        cancellationReason: null,
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Booking restored to active status.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    'Restore Active Booking',
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required Widget valueWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF64748B)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 2),
              valueWidget,
            ],
          ),
        ),
      ],
    );
  }
}
