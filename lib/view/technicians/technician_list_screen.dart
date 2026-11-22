import 'package:flutter/material.dart';

class TechnicianListScreen extends StatelessWidget {
  const TechnicianListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterRow(),
                const SizedBox(height: 12),
                _buildResultsHeader(),
                const SizedBox(height: 12),
                _buildAIBanner(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildTechnicianCard(_dummyTechnicians[index]);
              },
              childCount: _dummyTechnicians.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () {},
      ),
      titleSpacing: 0,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Plumbing repair",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            Icon(Icons.close, color: Colors.grey, size: 18),
            SizedBox(width: 12),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip("Sort: Top Rated", isSelected: true),
            const SizedBox(width: 8),
            _buildFilterChip("Location: Nearby (< 5 km)"),
            const SizedBox(width: 8),
            _buildFilterChipWithDot("Available Now"),
            const SizedBox(width: 8),
            _buildFilterChip("Price: Any"),
            const SizedBox(width: 8),
            _buildFilterChip("Experience: 5+ years"),
            const SizedBox(width: 8),
            _buildFilterChip("Rating: 4.5+"),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChipWithDot(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade700 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            color: isSelected ? Colors.white : Colors.black54,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "14 qualified technicians nearby",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              Icon(Icons.map_outlined, color: Colors.blue.shade700, size: 16),
              const SizedBox(width: 4),
              Text(
                "Map view",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF), // Light blue tint
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Smart Triage Active",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Showing verified leak & pipe burst specialists",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                "98%\nmatch",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicianCard(Map<String, dynamic> tech) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(tech['image']),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tech['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: Colors.blue, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "${tech['rating']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${tech['reviews']} reviews)",
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("From",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "\$${tech['price']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const TextSpan(
                          text: "/hr",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (tech['tags'] as List<String>).map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.near_me_outlined, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text("${tech['distance']} away",
                  style: const TextStyle(color: Colors.black54, fontSize: 12)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("•", style: TextStyle(color: Colors.black54)),
              ),
              const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  tech['availability'],
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Book",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue.shade700,
      unselectedItemColor: Colors.grey.shade500,
      currentIndex: 1, // 'Categories' tab is selected in your screenshot
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Bookings"),
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: "AI Assist"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}

// Dummy data to populate the UI based on your screenshot
final List<Map<String, dynamic>> _dummyTechnicians = [
  {
    "name": "Navam Shrestha",
    "rating": 4.9,
    "reviews": 128,
    "price": 40,
    "distance": "1.2 km",
    "availability": "Available today (in 45m)",
    "tags": ["Master Plumber", "Pipe Leak Expert", "Emergency 24/7"],
    "image": "https://i.pravatar.cc/150?img=11",
  },
  {
    "name": "Bikash KC",
    "rating": 4.8,
    "reviews": 94,
    "price": 35,
    "distance": "2.4 km",
    "availability": "Available today",
    "tags": ["Drain Specialist", "Water Heater", "Fixture Install"],
    "image": "https://i.pravatar.cc/150?img=68",
  },
  {
    "name": "Maya Henderson",
    "rating": 5.0,
    "reviews": 67,
    "price": 45,
    "distance": "3.1 km",
    "availability": "Available today (from 3:00 PM)",
    "tags": ["Diagnostic Audit", "High-Pressure Pipes", "Licensed Master"],
    "image": "https://i.pravatar.cc/150?img=44",
  }
];
