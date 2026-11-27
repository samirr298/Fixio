import 'package:flutter/material.dart';

class FavouriteTechniciansScreen extends StatefulWidget {
  const FavouriteTechniciansScreen({super.key});

  @override
  State<FavouriteTechniciansScreen> createState() =>
      _FavouriteTechniciansScreenState();
}

class _FavouriteTechniciansScreenState
    extends State<FavouriteTechniciansScreen> {
  // Frontend state simulation
  bool isAuthorized = true; // Toggleable for testing authorization requirement
  String selectedCategoryFilter = 'All';
  String searchQuery = '';

  // Initial list of saved favourite technicians
  List<Map<String, dynamic>> favouriteTechnicians = [
    {
      'id': 'tech_1',
      'name': 'Navam Shrestha',
      'category': 'Plumbing',
      'specialty': 'Master Plumber & Pipe Specialist',
      'rating': 4.9,
      'reviews': 128,
      'hourlyRate': 40,
      'location': 'Kathmandu • 1.5 km away',
      'isAvailable': true,
      'note': 'Fixed sink pipe quickly. Very professional.',
      'priority': 'Primary',
      'image':
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=400',
    },
    {
      'id': 'tech_2',
      'name': 'Bikash KC',
      'category': 'Electrical',
      'specialty': 'Certified Electrician & Wiring',
      'rating': 4.8,
      'reviews': 94,
      'hourlyRate': 35,
      'location': 'Patan • 2.4 km away',
      'isAvailable': true,
      'note': 'Installed main circuit breaker cleanly.',
      'priority': 'Backup',
      'image': 'https://i.pravatar.cc/150?img=68',
    },
    {
      'id': 'tech_3',
      'name': 'Maya Henderson',
      'category': 'HVAC',
      'specialty': 'AC & Heating Repair Expert',
      'rating': 5.0,
      'reviews': 67,
      'hourlyRate': 45,
      'location': 'Lalitpur • 3.1 km away',
      'isAvailable': false,
      'note': 'Annual AC servicing & filter replacement.',
      'priority': 'Emergency',
      'image': 'https://i.pravatar.cc/150?img=44',
    },
  ];

  final List<String> categories = ['All', 'Plumbing', 'Electrical', 'HVAC', 'Carpentry'];

  List<Map<String, dynamic>> get filteredTechnicians {
    return favouriteTechnicians.where((tech) {
      final matchesCategory = selectedCategoryFilter == 'All' ||
          tech['category'] == selectedCategoryFilter;
      final matchesSearch = tech['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          tech['specialty']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

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
          'Saved Technicians',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // Auth simulator toggle button for frontend demonstration
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
            onSelected: (value) {
              if (value == 'toggle_auth') {
                setState(() {
                  isAuthorized = !isAuthorized;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isAuthorized
                          ? 'User Status: Authorized / Logged In'
                          : 'User Status: Unauthorized / Logged Out',
                    ),
                    backgroundColor:
                        isAuthorized ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'toggle_auth',
                child: Row(
                  children: [
                    Icon(
                      isAuthorized ? Icons.lock_open : Icons.lock,
                      size: 18,
                      color: isAuthorized ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isAuthorized ? 'Simulate Logout' : 'Simulate Login',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: !isAuthorized
          ? _buildUnauthorizedState()
          : Column(
              children: [
                // Top Search & Controls Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      // Search Input
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search,
                                color: Color(0xFF64748B), size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    searchQuery = val;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search saved providers by name or skill...',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF94A3B8),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear,
                                    size: 16, color: Color(0xFF64748B)),
                                onPressed: () {
                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Category Chips Filter
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((cat) {
                            final isSelected = selectedCategoryFilter == cat;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(cat),
                                selected: isSelected,
                                selectedColor: const Color(0xFF0066FF),
                                backgroundColor: const Color(0xFFF8FAFC),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF475569),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: isSelected
                                        ? const Color(0xFF0066FF)
                                        : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      selectedCategoryFilter = cat;
                                    });
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFE2E8F0)),

                // List of Saved Technicians
                Expanded(
                  child: filteredTechnicians.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: filteredTechnicians.length,
                          itemBuilder: (context, index) {
                            final tech = filteredTechnicians[index];
                            return _buildSavedTechnicianCard(tech);
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: isAuthorized
          ? FloatingActionButton.extended(
              onPressed: () {
                _showAddOrEditModal(context);
              },
              backgroundColor: const Color(0xFF0066FF),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add Favourite Provider',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  // 1. Unauthorized state UI (Req #1 & Req #5)
  Widget _buildUnauthorizedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                size: 48,
                color: Color(0xFFDC2626),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Authentication Required',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please log in to access your saved favourite technicians and quick re-booking features.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isAuthorized = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Authorized! Welcome back to your saved providers.'),
                    backgroundColor: Color(0xFF16A34A),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.login),
              label: const Text(
                'Log In to View Favourites',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: Color(0xFFCBD5E1)),
          const SizedBox(height: 12),
          const Text(
            'No Saved Technicians Found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try adjusting your search or category filter.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // 2. Saved Technician Item Card (Req #2 & #4)
  Widget _buildSavedTechnicianCard(Map<String, dynamic> tech) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(tech['image']),
                    backgroundColor: const Color(0xFFE2E8F0),
                  ),
                  if (tech['isAvailable'] == true)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
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
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified,
                            color: Color(0xFF0066FF), size: 16),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tech['specialty'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0066FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 2),
                        Text(
                          '${tech['rating']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${tech['reviews']} jobs)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•  ${tech['location']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Favourite Heart Remove Action
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                tooltip: 'Remove from saved',
                onPressed: () {
                  _confirmRemove(tech);
                },
              ),
            ],
          ),

          // Custom Personal Note Box
          if (tech['note'] != null && tech['note'].toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.note_alt_outlined,
                      size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Note: "${tech['note']}"',
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showAddOrEditModal(context, techToEdit: tech);
                    },
                    child: const Icon(Icons.edit_outlined,
                        size: 14, color: Color(0xFF0066FF)),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),

          // Bottom Controls & Quick Actions
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Tag: ${tech['priority'] ?? 'Saved'}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0066FF),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'From \$${tech['hourlyRate']}/hr',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Re-booking request sent for ${tech['name']}!',
                      ),
                      backgroundColor: const Color(0xFF0066FF),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Book Provider',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Confirm Removal Dialog (Req #4 & Req #5)
  void _confirmRemove(Map<String, dynamic> tech) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Remove Provider?'),
        content: Text(
          'Are you sure you want to remove ${tech['name']} from your saved favourites list?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              setState(() {
                favouriteTechnicians
                    .removeWhere((item) => item['id'] == tech['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${tech['name']} removed from Favourites.'),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.yellow,
                    onPressed: () {
                      setState(() {
                        favouriteTechnicians.add(tech);
                      });
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  // 3. Add or Edit Provider Form Modal with Validation (Req #3, #4, #5)
  void _showAddOrEditModal(BuildContext context,
      {Map<String, dynamic>? techToEdit}) {
    final formKey = GlobalKey<FormState>();
    final isEditing = techToEdit != null;

    final nameController =
        TextEditingController(text: isEditing ? techToEdit['name'] : '');
    final noteController =
        TextEditingController(text: isEditing ? (techToEdit['note'] ?? '') : '');
    final rateController = TextEditingController(
        text: isEditing ? techToEdit['hourlyRate'].toString() : '40');

    String selectedCat = isEditing ? techToEdit['category'] : 'Plumbing';
    String selectedPriority =
        isEditing ? (techToEdit['priority'] ?? 'Primary') : 'Primary';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isEditing
                                ? 'Edit Saved Provider'
                                : 'Save New Favourite Provider',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(sheetCtx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Technician Name Input with Validation
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Technician Name *',
                          hintText: 'e.g. Ramesh Shrestha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter technician name.';
                          }
                          if (value.trim().length < 3) {
                            return 'Name must be at least 3 characters long.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Category Selector Dropdown with Validation
                      DropdownButtonFormField<String>(
                        value: selectedCat,
                        decoration: InputDecoration(
                          labelText: 'Service Category *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: ['Plumbing', 'Electrical', 'HVAC', 'Carpentry']
                            .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setSheetState(() {
                              selectedCat = val;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a service category.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Priority Selection
                      DropdownButtonFormField<String>(
                        value: selectedPriority,
                        decoration: InputDecoration(
                          labelText: 'Priority Tag',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: ['Primary', 'Backup', 'Emergency']
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setSheetState(() {
                              selectedPriority = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // Hourly Rate Input with Number Validation
                      TextFormField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Hourly Rate (\$) *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter an hourly rate.';
                          }
                          final parsed = double.tryParse(value);
                          if (parsed == null || parsed <= 0) {
                            return 'Please enter a valid positive rate.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Personal Note Input
                      TextFormField(
                        controller: noteController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Personal Note (Optional)',
                          hintText: 'e.g. Recommended by neighbor, good with pipes',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button with Validation & Confirmation (Req #3 & #4)
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate form
                            if (!formKey.currentState!.validate()) {
                              // Requirement #3 & #5: Incomplete input explained clearly
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please resolve highlighted form errors before saving.',
                                  ),
                                  backgroundColor: Color(0xFFDC2626),
                                ),
                              );
                              return;
                            }

                            // Successful Action (Req #4)
                            if (isEditing) {
                              setState(() {
                                techToEdit['name'] = nameController.text.trim();
                                techToEdit['category'] = selectedCat;
                                techToEdit['priority'] = selectedPriority;
                                techToEdit['hourlyRate'] =
                                    int.tryParse(rateController.text) ?? 40;
                                techToEdit['note'] = noteController.text.trim();
                              });
                            } else {
                              setState(() {
                                favouriteTechnicians.insert(0, {
                                  'id': 'tech_${DateTime.now().millisecondsSinceEpoch}',
                                  'name': nameController.text.trim(),
                                  'category': selectedCat,
                                  'specialty': '$selectedCat Specialist',
                                  'rating': 5.0,
                                  'reviews': 1,
                                  'hourlyRate':
                                      int.tryParse(rateController.text) ?? 40,
                                  'location': 'Kathmandu • 1.0 km away',
                                  'isAvailable': true,
                                  'note': noteController.text.trim(),
                                  'priority': selectedPriority,
                                  'image': 'https://i.pravatar.cc/150?img=33',
                                });
                              });
                            }

                            Navigator.pop(sheetCtx);

                            // Confirmation feedback (Req #4)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEditing
                                      ? 'Provider details updated successfully!'
                                      : 'Technician "${nameController.text.trim()}" saved to your favourites!',
                                ),
                                backgroundColor: const Color(0xFF16A34A),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isEditing ? 'Update Saved Record' : 'Save to Favourites',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
