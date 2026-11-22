
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String searchQuery = '';

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Plumbing',
      'icon': Icons.plumbing,
      'services': [
        'Pipe leak repair',
        'Drain cleaning',
        'Tap & shower fixture',
        'Water heater',
      ],
      'popular': true,
    },
    {
      'title': 'Electrical',
      'icon': Icons.bolt,
      'services': [
        'Wiring repair',
        'Lighting installation',
        'Switch & socket repair',
        'Circuit breaker',
      ],
    },
    {
      'title': 'Appliances',
      'icon': Icons.kitchen_outlined,
      'services': [
        'Washing machine',
        'Refrigerator repair',
        'Microwave repair',
        'Dishwasher repair',
      ],
    },
    {
      'title': 'Heating & AC',
      'icon': Icons.ac_unit,
      'services': [
        'AC repair',
        'AC installation',
        'Heating repair',
        'Ventilation',
      ],
    },
    {
      'title': 'Carpentry & Furniture',
      'icon': Icons.handyman_outlined,
      'services': [
        'Furniture repair',
        'Door repair',
        'Cabinet installation',
      ],
    },
    {
      'title': 'Painting & Walls',
      'icon': Icons.format_paint_outlined,
      'services': [
        'Interior painting',
        'Wall repair',
        'Wallpaper installation',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((category) {
      final title = category['title'].toString().toLowerCase();
      final services =
      (category['services'] as List<String>).join(' ').toLowerCase();

      return title.contains(searchQuery.toLowerCase()) ||
          services.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black87,
          size: 20,
        ),
        title: const Text(
          'Service Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.black87,
              size: 20,
            ),
          ),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SEARCH BAR
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search categories & services',
                hintStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color(0xFFF7F8FC),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6DFF0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6DFF0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // AI BANNER
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD6DFF0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.smart_toy_outlined,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Not sure what's broken?",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Instant diagnosis with Fixio AI camera scan',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // SECTION HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Core Diagnostics & Repairs',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${filteredCategories.length} Disciplines',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // CATEGORY CARDS
            ...filteredCategories.map((category) {
              final services = category['services'] as List<String>;

              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: Color(0xFFD6DFF0),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                  childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 8),

                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),

                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          category['title'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (category['popular'] == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF1FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  subtitle: Text(
                    '${services.length} core sub-services',
                    style: const TextStyle(fontSize: 10),
                  ),

                  children: services.map((service) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              service,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 11,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

            const SizedBox(height: 14),

            // VERIFIED BANNER
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD6DFF0),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.blue,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'All technicians are background-checked, insured, and verified under Fixio Standards.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xFF64748B),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_outlined),
            label: 'AI Assist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
