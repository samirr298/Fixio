import 'package:flutter/material.dart';

class TechnicianProfileScreen extends StatefulWidget {
  const TechnicianProfileScreen({super.key});

  @override
  State<TechnicianProfileScreen> createState() => _TechnicianProfileScreenState();
}

class _TechnicianProfileScreenState extends State<TechnicianProfileScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Technician Profile',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : const Color(0xFF0F172A),
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Technician Header Info Section
            Center(
              child: Column(
                children: [
                  // Profile Image with Verified Badge
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE2E8F0),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=400',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0066FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Name
                  const Text(
                    'Navam Shrestha',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Specialization
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.build_rounded,
                        size: 16,
                        color: Color(0xFF0066FF),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Plumber & Pipe Specialist',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Kathmandu • 1.5 km away',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Availability Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0066FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Next available: Today at 2:30 PM',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0066FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  // Stat 1
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '4.9',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFFF59E0B),
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '128 reviews',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 1,
                    color: const Color(0xFFE2E8F0),
                  ),
                  // Stat 2
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          '450+',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Jobs Done',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 1,
                    color: const Color(0xFFE2E8F0),
                  ),
                  // Stat 3
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          '100%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'On-time',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Section
            const Text(
              'About',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Master technician with over 8 years of certified residential and commercial plumbing experience. Specializing in precision diagnostic leak detection, prompt pipe installations, and sanitary maintenance.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF475569),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Services & Pricing Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Services & Pricing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  'Standard Rates',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Service Card 1
            _buildServiceCard(
              icon: Icons.home_outlined,
              title: 'Leak Inspection',
              subtitle: 'Acoustic & thermal diagnostics',
              price: '\$35',
            ),
            const SizedBox(height: 10),

            // Service Card 2
            _buildServiceCard(
              icon: Icons.build_outlined,
              title: 'Pipe Replacement',
              subtitle: 'Copper, PVC & PEX fittings',
              price: '\$50',
              unit: ' /hr',
            ),
            const SizedBox(height: 10),

            // Service Card 3
            _buildServiceCard(
              icon: Icons.report_problem_outlined,
              title: 'Emergency Callout',
              subtitle: 'Within 45 min priority response',
              price: '\$60',
            ),
            const SizedBox(height: 24),

            // Recent Customer Reviews Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Customer Reviews',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0066FF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Review Card 1
            _buildReviewCard(
              initials: 'AK',
              name: 'Aarav Karki',
              time: 'Yesterday',
              rating: 5,
              comment:
                  'Arrived within 30 minutes for a burst sink pipe. Diagnosed the pressure fault right away and cleanly replaced the joint. Extremely courteous.',
            ),
            const SizedBox(height: 10),

            // Review Card 2
            _buildReviewCard(
              initials: 'SM',
              name: 'Sunita Maharjan',
              time: '3 days ago',
              rating: 5,
              comment:
                  'Very transparent pricing and clean workflow. Navam explained the root cause and completed the installation without any hassle.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE2E8F0)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Starting Rate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: const TextSpan(
                      text: 'From \$40',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      children: [
                        TextSpan(
                          text: ' /hr',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String price,
    String? unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0066FF),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
              children: unit != null
                  ? [
                      TextSpan(
                        text: unit,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String initials,
    required String name,
    required String time,
    required int rating,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFDBEAFE),
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E40AF),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  rating,
                  (index) => const Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
