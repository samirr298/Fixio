import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color blue = Color(0xFF2563EB);
  static const Color borderColor = Color(0xFFD8E1F0);
  static const Color muted = Color(0xFF64748B);

  int selectedIndex = 4;

  String userName = 'Agrim Sharma';
  String email = 'agrim.sharma@fixio.app';
  String phone = '+977 9801234567';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // TOP APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Row(
          children: [

            const SizedBox(width: 8),
            const Text(
              'Fixio',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/logo.jpeg',
                height: 35,
                width: 35,
              ),
            ),],

        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Icon(
            Icons.account_circle_outlined,
            color: Colors.grey,
          ),
          SizedBox(width: 16),
        ],
      ),

      // MAIN CONTENT
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileCard(),

              const SizedBox(height: 14),

              technicianCard(),

              const SizedBox(height: 20),

              sectionTitle('ACCOUNT & LOCATIONS'),

              sectionCard([
                settingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Saved Addresses',
                  subtitle: 'Downtown Apt, 4B, Kathmandu',
                  onTap: () {
                    showInfoDialog(
                      'Saved Addresses',
                      'Downtown Apt, 4B, Kathmandu',
                    );
                  },
                ),

                settingsTile(
                  icon: Icons.contact_phone_outlined,
                  title: 'Emergency Contacts',
                  subtitle: '1 registered',
                  showDivider: false,
                  onTap: () {
                    showInfoDialog(
                      'Emergency Contacts',
                      'Your emergency contact is registered.',
                    );
                  },
                ),
              ]),

              const SizedBox(height: 20),

              sectionTitle('PREFERENCES'),

              sectionCard([
                settingsTile(
                  icon: Icons.notifications_none,
                  title: 'Notification Preferences',
                  subtitle: 'Push, SMS',
                  onTap: () {
                    showNotificationDialog();
                  },
                ),

                settingsTile(
                  icon: Icons.translate,
                  title: 'Language',
                  subtitle: 'English',
                  showDivider: false,
                  onTap: () {
                    showLanguageDialog();
                  },
                ),
              ]),

              const SizedBox(height: 20),

              sectionTitle('SUPPORT & LEGAL'),

              sectionCard([
                settingsTile(
                  icon: Icons.support_agent,
                  title: 'Help Center & Support',
                  subtitle: '24/7 dedicated dispatch team',
                  onTap: () {
                    showInfoDialog(
                      'Help Center & Support',
                      'Contact the Fixio support team for assistance.',
                    );
                  },
                ),

                settingsTile(
                  icon: Icons.gavel_outlined,
                  title: 'Fixio Service Terms & Privacy',
                  subtitle: 'Version 2.4.1',
                  showDivider: false,
                  onTap: () {
                    showInfoDialog(
                      'Terms & Privacy',
                      'Fixio Service Terms & Privacy - Version 2.4.1',
                    );
                  },
                ),
              ]),

              const SizedBox(height: 20),

              // LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: showLogoutDialog,
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Log Out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'Fixio Mobile Service Client v2.4.1 (Build 118)',
                  style: TextStyle(
                    fontSize: 10,
                    color: muted,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: bottomNavigation(),
    );
  }

  // --------------------------------------------------
  // PROFILE CARD
  // --------------------------------------------------

  Widget profileCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: cardDecoration(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AVATAR
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD6E4FF),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'AS',
                  style: TextStyle(
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // USER DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            userName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 15,
                          color: blue,
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),

                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              // EDIT BUTTON
              OutlinedButton(
                onPressed: showEditProfileDialog,
                style: OutlinedButton.styleFrom(
                  foregroundColor: blue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // VERIFICATION ROW
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Verified Homeowner',
                  style: TextStyle(
                    color: blue,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              const Expanded(
                child: Text(
                  'Member since 2023',
                  style: TextStyle(
                    fontSize: 10,
                    color: muted,
                  ),
                ),
              ),

              const Icon(
                Icons.shield_outlined,
                size: 16,
                color: muted,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // TECHNICIAN DASHBOARD CARD
  // --------------------------------------------------

  Widget technicianCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.handyman_outlined,
              color: blue,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Technician Dashboard',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  'Switch to work profile and incoming jobs',
                  style: TextStyle(
                    fontSize: 10,
                    color: muted,
                  ),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: () {
              showInfoDialog(
                'Technician Dashboard',
                'You switched to the technician dashboard (demo).',
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFEAF1FF),
              foregroundColor: blue,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 30),
            ),
            child: const Text(
              'Switch',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // SECTION TITLE
  // --------------------------------------------------

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: muted,
          fontWeight: FontWeight.w600,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // --------------------------------------------------
  // SECTION CARD
  // --------------------------------------------------

  Widget sectionCard(List<Widget> tiles) {
    return Container(
      decoration: cardDecoration(),
      child: Column(
        children: tiles,
      ),
    );
  }

  // --------------------------------------------------
  // REUSABLE SETTINGS TILE
  // --------------------------------------------------

  Widget settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Row(
              children: [
                // ICON
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: blue,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 12),

                // TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          color: muted,
                        ),
                      ),
                    ],
                  ),
                ),

                // ARROW
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: muted,
                ),
              ],
            ),
          ),
        ),

        if (showDivider)
          const Divider(
            height: 1,
            indent: 12,
            endIndent: 12,
            color: Color(0xFFE9EDF5),
          ),
      ],
    );
  }

  // --------------------------------------------------
  // CARD DECORATION
  // --------------------------------------------------

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(12),
    );
  }

  // --------------------------------------------------
  // BOTTOM NAVIGATION
  // --------------------------------------------------

  Widget bottomNavigation() {
    final icons = [
      Icons.home_outlined,
      Icons.grid_view_outlined,
      Icons.calendar_month_outlined,
      Icons.auto_awesome_outlined,
      Icons.person_outline,
    ];

    final labels = [
      'Home',
      'Categories',
      'Bookings',
      'AI Assist',
      'Profile',
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(5, (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    // Demo navigation feedback
                    if (index != 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${labels[index]} tab selected (demo)',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 20,
                        color: isSelected ? blue : muted,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 9,
                          color: isSelected ? blue : muted,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // EDIT PROFILE DIALOG
  // --------------------------------------------------

  void showEditProfileDialog() {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                  ),
                ),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),

                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // --------------------------------------------------
  // NOTIFICATION DIALOG
  // --------------------------------------------------

  void showNotificationDialog() {
    bool pushEnabled = true;
    bool smsEnabled = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Notification Preferences'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    value: pushEnabled,
                    onChanged: (value) {
                      setDialogState(() {
                        pushEnabled = value;
                      });
                    },
                  ),

                  SwitchListTile(
                    title: const Text('SMS Notifications'),
                    value: smsEnabled,
                    onChanged: (value) {
                      setDialogState(() {
                        smsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --------------------------------------------------
  // LANGUAGE DIALOG
  // --------------------------------------------------

  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.pop(dialogContext);
                },
              ),

              ListTile(
                title: const Text('Nepali'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  showInfoDialog(
                    'Language',
                    'Nepali selected (demo only).',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --------------------------------------------------
  // LOGOUT CONFIRMATION
  // --------------------------------------------------

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text(
            'Are you sure you want to log out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out (demo only).'),
                  ),
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // --------------------------------------------------
  // GENERAL INFORMATION DIALOG
  // --------------------------------------------------

  void showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}