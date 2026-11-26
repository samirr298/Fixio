import 'package:flutter/material.dart';

import '../../model/booking_history_model.dart';
import 'booking_history_detail_sheet.dart';
import 'reschedule_cancel_booking_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  late List<BookingHistoryModel> historyList;

  // Search & Filter States (Acceptance Criteria 2 & 3)
  final TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';
  String selectedDateRange = 'All Time';

  // Validation & Error Simulation (Acceptance Criteria 3 & 5)
  String? searchError;
  bool simulateLoadError = false;
  bool isLoading = false;

  final List<String> filterTabs = ['All', 'Upcoming', 'Completed', 'Cancelled'];
  final List<String> dateRanges = ['All Time', 'This Month', 'Past 30 Days', 'Past 90 Days'];

  @override
  void initState() {
    super.initState();
    historyList = getAgrimBookingHistory();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Filter & Search Logic
  List<BookingHistoryModel> get filteredList {
    if (simulateLoadError) return [];

    final query = searchController.text.trim().toLowerCase();
    final now = DateTime.now();

    return historyList.where((item) {
      // Tab Filter
      if (selectedFilter == 'Upcoming' &&
          (item.status != HistoryBookingStatus.upcoming &&
              item.status != HistoryBookingStatus.rescheduled)) {
        return false;
      }
      if (selectedFilter == 'Completed' && item.status != HistoryBookingStatus.completed) {
        return false;
      }
      if (selectedFilter == 'Cancelled' && item.status != HistoryBookingStatus.cancelled) {
        return false;
      }

      // Date Range Filter
      if (selectedDateRange == 'This Month' &&
          (item.date.month != now.month || item.date.year != now.year)) {
        return false;
      }
      if (selectedDateRange == 'Past 30 Days' &&
          now.difference(item.date).inDays > 30) {
        return false;
      }

      // Search Query Matching
      if (query.isNotEmpty) {
        final matchesTitle = item.serviceTitle.toLowerCase().contains(query);
        final matchesSpecialist = item.specialistName.toLowerCase().contains(query);
        final matchesId = item.bookingId.toLowerCase().contains(query);
        final matchesCategory = item.category.toLowerCase().contains(query);
        return matchesTitle || matchesSpecialist || matchesId || matchesCategory;
      }

      return true;
    }).toList();
  }

  void _onSearchChanged(String val) {
    setState(() {
      if (val.isNotEmpty && val.trim().length < 2) {
        searchError = 'Search term must be at least 2 characters.';
      } else {
        searchError = null;
      }
    });
  }

  // Rating & Review Modal (Acceptance Criteria 4 - Record Saved & Confirmation)
  void _openRatingDialog(BookingHistoryModel item) {
    double selectedStars = 5.0;
    final TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Column(
                children: [
                  Icon(Icons.rate_review_outlined, color: Color(0xFF0066FF), size: 36),
                  SizedBox(height: 8),
                  Text(
                    'Rate Service & Pro',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${item.serviceTitle} by ${item.specialistName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 16),

                    // Star Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starValue = index + 1.0;
                        return IconButton(
                          icon: Icon(
                            starValue <= selectedStars ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: const Color(0xFFF59E0B),
                            size: 32,
                          ),
                          onPressed: () {
                            setModalState(() {
                              selectedStars = starValue;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: reviewController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Share feedback for Agrim Shrestha\'s record...',
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
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      final idx = historyList.indexWhere((b) => b.bookingId == item.bookingId);
                      if (idx != -1) {
                        historyList[idx] = historyList[idx].copyWith(
                          userRating: selectedStars,
                          userReviewText: reviewController.text.trim().isEmpty
                              ? 'Great service completed on time.'
                              : reviewController.text.trim(),
                        );
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Review saved! Rated ${selectedStars.toInt()} stars for #${item.bookingId}.'),
                        backgroundColor: const Color(0xFF16A34A),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Submit Rating', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Re-book Service Logic (Acceptance Criteria 4)
  void _rebookService(BookingHistoryModel item) {
    setState(() {
      final now = DateTime.now();
      final newBooking = BookingHistoryModel(
        bookingId: 'FIX-${89000 + historyList.length * 15}',
        customerName: item.customerName,
        customerRole: item.customerRole,
        serviceTitle: item.serviceTitle,
        serviceSubtitle: item.serviceSubtitle,
        category: item.category,
        specialistName: item.specialistName,
        specialistTitle: item.specialistTitle,
        specialistRating: item.specialistRating,
        isVerifiedPro: item.isVerifiedPro,
        tagLabel: item.tagLabel,
        tagColor: item.tagColor,
        date: now.add(const Duration(days: 2)),
        timeSlot: '02:30 PM',
        serviceAddress: item.serviceAddress,
        accessNote: item.accessNote,
        estimatedTotalNpr: item.estimatedTotalNpr,
        status: HistoryBookingStatus.upcoming,
      );

      historyList.insert(0, newBooking);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Re-booking created! New service #${historyList.first.bookingId} added to upcoming history.'),
        backgroundColor: const Color(0xFF0066FF),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
    final completedCount = historyList.where((b) => b.status == HistoryBookingStatus.completed).length;
    final upcomingCount = historyList.where((b) => b.status == HistoryBookingStatus.upcoming || b.status == HistoryBookingStatus.rescheduled).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Booking History',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF64748B)),
            onPressed: () {
              setState(() {
                searchController.clear();
                selectedFilter = 'All';
                selectedDateRange = 'All Time';
                simulateLoadError = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking history refreshed.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [

          // Authorized Customer Header Banner (Acceptance Criteria 1)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0x1F0066FF),
                  child: const Icon(Icons.person, color: Color(0xFF0066FF), size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agrim Shrestha',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'Student & Customer • Routine Maintenance',
                        style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified, size: 12, color: Color(0xFF16A34A)),
                      SizedBox(width: 4),
                      Text(
                        'Authorized',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF15803D)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Summary Stats Bar (Acceptance Criteria 2)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Services', '${historyList.length}', const Color(0xFF0066FF)),
                _buildStatItem('Upcoming', '$upcomingCount', const Color(0xFF3B82F6)),
                _buildStatItem('Completed', '$completedCount', const Color(0xFF16A34A)),
                _buildStatItem('Cancelled', '${historyList.length - upcomingCount - completedCount}', const Color(0xFFEF4444)),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Search & Date Filter Bar (Acceptance Criteria 2 & 3)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search service, ID, or specialist...',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18, color: Color(0xFF64748B)),
                                  onPressed: () {
                                    searchController.clear();
                                    _onSearchChanged('');
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Date Range Selector Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedDateRange,
                          icon: const Icon(Icons.filter_list, size: 18, color: Color(0xFF0066FF)),
                          style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
                          items: dateRanges.map((range) {
                            return DropdownMenuItem<String>(
                              value: range,
                              child: Text(range),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                selectedDateRange = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                if (searchError != null) ...[
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      searchError!,
                      style: const TextStyle(color: Color(0xFFDC2626), fontSize: 11),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Horizontal Filter Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filterTabs.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tab = filterTabs[index];
                  final isSelected = selectedFilter == tab;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = tab;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0066FF) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // SIMULATION SWITCH FOR ACCEPTANCE CRITERIA 5 (Error Handling)
          Container(
            color: const Color(0xFFFFFBEB),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.bug_report_outlined, color: Color(0xFFD97706), size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Simulate History Load Error (Criteria 5)',
                    style: TextStyle(fontSize: 11, color: Color(0xFFB45309), fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: simulateLoadError,
                  activeTrackColor: const Color(0xFFFDE68A),
                  onChanged: (val) {
                    setState(() {
                      simulateLoadError = val;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // BOOKING HISTORY LIST / ERROR / EMPTY STATES
          Expanded(
            child: _buildHistoryContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryContent(BuildContext context) {
    // Acceptance Criteria 5: Handle System Errors cleanly
    if (simulateLoadError) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFCA5A5)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, color: Color(0xFFDC2626), size: 48),
              const SizedBox(height: 12),
              const Text(
                'Unable to Load Booking History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 6),
              const Text(
                'A network timeout occurred while retrieving service history for Agrim Shrestha. Please retry.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    simulateLoadError = false;
                  });
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
                label: const Text('Retry Loading History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }

    final results = filteredList;

    // Acceptance Criteria 3: Validation & Empty State Explanation
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF94A3B8)),
              const SizedBox(height: 12),
              Text(
                'No service history found for "$selectedFilter" ($selectedDateRange)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Try adjusting your search terms or filter selections.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0066FF)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    searchController.clear();
                    selectedFilter = 'All';
                    selectedDateRange = 'All Time';
                  });
                },
                child: const Text('Reset All Filters', style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return _buildBookingHistoryCard(context, item);
      },
    );
  }

  Widget _buildBookingHistoryCard(BuildContext context, BookingHistoryModel item) {
    Color statusBg = const Color(0xFFEFF6FF);
    Color statusColor = const Color(0xFF0066FF);
    String statusText = 'UPCOMING';

    if (item.status == HistoryBookingStatus.completed) {
      statusBg = const Color(0xFFDCFCE7);
      statusColor = const Color(0xFF16A34A);
      statusText = 'COMPLETED';
    } else if (item.status == HistoryBookingStatus.cancelled) {
      statusBg = const Color(0xFFFEE2E2);
      statusColor = const Color(0xFFEF4444);
      statusText = 'CANCELLED';
    } else if (item.status == HistoryBookingStatus.rescheduled) {
      statusBg = const Color(0xFFFEF3C7);
      statusColor = const Color(0xFFD97706);
      statusText = 'RESCHEDULED';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booking ID & Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking #${item.bookingId}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Service Details Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.cleaning_services_outlined,
                        color: Color(0xFF0066FF),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.serviceTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Specialist: ${item.specialistName} • ⭐ ${item.specialistRating}',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Date & Amount Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 18, color: Color(0xFF0066FF)),
                      const SizedBox(width: 8),
                      Text(
                        '${_getMonthName(item.date)} ${item.date.day} at ${item.timeSlot}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'NPR ${item.estimatedTotalNpr.toInt()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Card Footer Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    BookingHistoryDetailSheet.show(
                      context,
                      booking: item,
                      onRebook: () => _rebookService(item),
                    );
                  },
                  icon: const Icon(Icons.receipt_long_outlined, size: 16, color: Color(0xFF0F172A)),
                  label: const Text(
                    'View Receipt',
                    style: TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),

                const Spacer(),

                // Action Buttons based on status
                if (item.status == HistoryBookingStatus.completed) ...[
                  if (item.userRating != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${item.userRating}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFB45309)),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: Color(0xFF0066FF)),
                      ),
                      onPressed: () => _openRatingDialog(item),
                      icon: const Icon(Icons.star_outline_rounded, size: 16, color: Color(0xFF0066FF)),
                      label: const Text('Rate Pro', style: TextStyle(color: Color(0xFF0066FF), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066FF),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () => _rebookService(item),
                    icon: const Icon(Icons.refresh, size: 16, color: Colors.white),
                    label: const Text('Re-book', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ] else if (item.status == HistoryBookingStatus.upcoming || item.status == HistoryBookingStatus.rescheduled) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066FF),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RescheduleCancelBookingScreen(),
                        ),
                      );
                    },
                    child: const Text('Manage Appointment', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
        ),
      ],
    );
  }
}
