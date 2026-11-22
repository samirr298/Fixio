import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // 6 digit OTP Controllers & FocusNodes
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  bool _obscurePassword = true;
  String _selectedCountryCode = '+977';
  String _selectedRole = 'Customer'; // 'Customer' or 'Technician'
  bool _isLoading = false;

  final List<Map<String, String>> _countryCodes = [
    {'code': '+977', 'flag': 'NP', 'name': 'Nepal'},
    {'code': '+1', 'flag': 'US', 'name': 'USA'},
    {'code': '+44', 'flag': 'UK', 'name': 'UK'},
    {'code': '+91', 'flag': 'IN', 'name': 'India'},
    {'code': '+61', 'flag': 'AU', 'name': 'Australia'},
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        _otpFocusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        _otpFocusNodes[index - 1].requestFocus();
      }
    }
  }

  void _handleRegister() async {
    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final otpCode = _otpControllers.map((c) => c.text).join();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account created successfully as $_selectedRole! Code: $otpCode',
        ),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _navigateToLogin() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFF1F5F9),
                    width: 1.0,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 22,
                        color: Color(0xFF0F172A),
                      ),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEFF5FF),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Images/fixio_logo.png',
                              width: 28,
                              height: 28,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/fixio_logo.png',
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.build_circle,
                                      size: 20,
                                      color: Color(0xFF0066FF),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Fixio',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),

                      // Title
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 1. Full Name
                      const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _fullNameController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: 'Agrim Shrestha',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.badge_outlined,
                            color: Color(0xFF64748B),
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 2. Email Address
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: 'agrim.shrestha@fixio.io',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.mail_outline_rounded,
                            color: Color(0xFF64748B),
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 3. Phone Number
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Country Code Selector
                          Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF64748B),
                                  size: 18,
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F172A),
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCountryCode = value;
                                    });
                                  }
                                },
                                items: _countryCodes.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['code'],
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFFCBD5E1)),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: Text(
                                            item['flag']!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF475569),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(item['code']!),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Phone Number Input
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                              decoration: InputDecoration(
                                hintText: '9841234567',
                                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // 4. Secure Password
                      const Text(
                        'Secure Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: '••••••••••••••••',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Color(0xFF64748B),
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF94A3B8),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 5. Verification Code (OTP)
                      const Text(
                        'Verification Code',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 48,
                            height: 54,
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _otpFocusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: index == 5 ? '•' : null,
                                hintStyle: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFCBD5E1),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF0066FF),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onChanged: (value) => _handleOtpInput(value, index),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // 6. Role Selection Buttons: TECHNICIAN vs Customer
                      Row(
                        children: [
                          // TECHNICIAN Button (Red accent #FF2D55)
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedRole = 'Technician';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedRole == 'Technician'
                                      ? const Color(0xFFFF2D55)
                                      : Colors.white,
                                  foregroundColor: _selectedRole == 'Technician'
                                      ? Colors.white
                                      : const Color(0xFFFF2D55),
                                  elevation: 0,
                                  side: BorderSide(
                                    color: const Color(0xFFFF2D55),
                                    width: _selectedRole == 'Technician' ? 0 : 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'TECHNICIAN',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Customer Button (Blue accent #0066FF)
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedRole = 'Customer';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedRole == 'Customer'
                                      ? const Color(0xFF0066FF)
                                      : Colors.white,
                                  foregroundColor: _selectedRole == 'Customer'
                                      ? Colors.white
                                      : const Color(0xFF0066FF),
                                  elevation: 0,
                                  side: BorderSide(
                                    color: const Color(0xFF0066FF),
                                    width: _selectedRole == 'Customer' ? 0 : 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Customer',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // 7. Register Button
                      SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066FF),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0x990066FF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // Footer: Already have an account? Log In
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF1F5F9),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0066FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
