import 'package:flutter/material.dart';
import 'schedule_estimate_screen.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _gateCodeController =
      TextEditingController(text: "Gate code 4021, 2nd floor");

  int _charCount = 0;
  bool _showError = false;

  // Mock list of uploaded photos
  final List<Map<String, String>> _photos = [
    {
      "name": "Sink_pipe.jpg",
      "url": "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=150"
    },
    {
      "name": "Valve_leak.jpg",
      "url": "https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=150"
    },
  ];

  @override
  void initState() {
    super.initState();
    _issueController.addListener(() {
      setState(() {
        _charCount = _issueController.text.length;
        if (_issueController.text.trim().length >= 10 && _showError) {
          _showError = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _issueController.dispose();
    _gateCodeController.dispose();
    super.dispose();
  }

  // Acceptance Criteria #3, #4, #5 Logic
  void _handleContinueToSchedule() {
    final text = _issueController.text.trim();
    if (text.length < 10) {
      setState(() => _showError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Please describe the issue (minimum 10 characters) before continuing.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Success Action (Acceptance Criteria #4): Confirm and Navigate to Step 2
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Text("Service booking details saved! Moving to Step 2..."),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScheduleEstimateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpecialistCard(),
            const SizedBox(height: 20),
            _buildIssueDescriptionSection(),
            const SizedBox(height: 20),
            _buildUploadMediaSection(),
            const SizedBox(height: 20),
            _buildServiceAddressSection(),
            const SizedBox(height: 20),
            _buildGuaranteeFooter(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Details",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "STEP 1 OF 3",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "Diagnostics",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: LinearProgressIndicator(
          value: 1 / 3,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
        ),
      ),
    );
  }

  Widget _buildSpecialistCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ASSIGNED SPECIALIST",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Direct Match",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=11"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.verified,
                          color: Colors.blue, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Navam Shrestha",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "Master Plumber",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child:
                              Text("•", style: TextStyle(color: Colors.black54)),
                        ),
                        Icon(Icons.star, color: Colors.blue, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "4.9",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$40",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue),
                    ),
                    TextSpan(
                      text: "/hr",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.edit_outlined,
                    color: Colors.blue.shade700, size: 18),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Service",
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                      Text(
                        "Pipe Leak Repair",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          color: Colors.blue.shade700, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Describe the Issue ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Diagnostic input",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _showError ? Colors.red.shade600 : Colors.grey.shade300,
              width: _showError ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _issueController,
                maxLength: 500,
                maxLines: 4,
                buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    maxLength}) =>
                    null, // Custom counter inside box below
                decoration: const InputDecoration(
                  hintText:
                      "E.g. Kitchen sink pipe leaking under the cabinet, water dripping consistently...",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 13),
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome,
                            color: Colors.blue.shade700, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          "AI will evaluate issue scope",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$_charCount/500",
                      style:
                          const TextStyle(fontSize: 11, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 4.0),
            child: Text(
              "Please provide a brief description of the issue.",
              style: TextStyle(color: Colors.red.shade600, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildUploadMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Upload Photos / Media ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "(Optional)",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${_photos.length} / 3 added",
              style: const TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          "Add up to 3 photos of the issue for accurate diagnosis and transparent pricing.",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ..._photos.map((photo) {
              return Container(
                width: 95,
                height: 95,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(photo['url']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(120),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _photos.remove(photo);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 6,
                      right: 6,
                      child: Text(
                        photo['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (_photos.length < 3)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _photos.add({
                      "name": "Pipe_leak_${_photos.length + 1}.jpg",
                      "url":
                          "https://images.unsplash.com/photo-1585704032915-c3400ca199e7?w=150"
                    });
                  });
                },
                child: Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.shade200,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined,
                          color: Colors.blue.shade700, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        "Add Photo",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "JPG, PNG",
                        style: TextStyle(color: Colors.black38, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Service Address",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Change",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.location_on_outlined,
                        color: Colors.blue.shade700, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Home",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Primary",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.black45),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Downtown Apt 4B, Kathmandu",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Bagmati Province, Nepal",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Colors.grey, height: 1),
              ),
              Row(
                children: [
                  const Icon(Icons.vpn_key_outlined,
                      size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text(
                    "Access / Gate Instructions",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _gateCodeController,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuaranteeFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shield_outlined, color: Colors.blue.shade700, size: 16),
        const SizedBox(width: 6),
        Text(
          "Fixio Guarantee: Certified Pros & Upfront Quotes",
          style: TextStyle(
            fontSize: 11,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ESTIMATED RATE",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "\$40 ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: "base + parts",
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _handleContinueToSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: const [
                  Text(
                    "Continue to Schedule",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
