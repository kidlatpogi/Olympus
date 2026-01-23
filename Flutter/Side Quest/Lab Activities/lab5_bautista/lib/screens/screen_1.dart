import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address or phone number is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final mobileRegex = RegExp(r'^09[0-9]{9}$');
    if (!emailRegex.hasMatch(value) && !mobileRegex.hasMatch(value)) {
      return 'Invalid email or mobile format';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _validateAndLogin();
    }
  }

  Future<void> _validateAndLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('user_email')?.trim();
    final storedPassword = prefs.getString('user_password')?.trim();
    final firstName = prefs.getString('first_name');
    final lastName = prefs.getString('last_name');

    final enteredEmail = _emailController.text.trim();
    final enteredPassword = _passwordController.text.trim();

    // Debug: Print values to help diagnose
    debugPrint('Stored Email: "$storedEmail"');
    debugPrint('Entered Email: "$enteredEmail"');
    debugPrint('Stored Password: "$storedPassword"');
    debugPrint('Entered Password: "$enteredPassword"');

    // Validate credentials
    if (storedEmail == null ||
        storedEmail.isEmpty ||
        storedPassword == null ||
        storedPassword.isEmpty) {
      _showErrorDialog(
        'Account Not Found',
        'No account found. Please sign up first.',
      );
      return;
    }

    if (enteredEmail != storedEmail || enteredPassword != storedPassword) {
      _showErrorDialog(
        'Invalid Credentials',
        'Email/Mobile or password is incorrect.\n\nStored: $storedEmail\nEntered: $enteredEmail',
      );
      return;
    }

    // Credentials match - show success modal
    _showLoginSuccessModal(firstName ?? '', lastName ?? '', storedEmail);
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(title, style: const TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLoginSuccessModal(String firstName, String lastName, String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login Successful!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1877F2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF606770),
                  ),
                ),
                const SizedBox(height: 12),
                _buildLoginModalInfoRow('Full Name:', '$firstName $lastName'),
                const SizedBox(height: 10),
                _buildLoginModalInfoRow('Email/Mobile:', email),
                const SizedBox(height: 20),
                const Text(
                  'You are now logged in to your National University account.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF65676B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go('/main');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginModalInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1877F2),
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Color(0xFF606770), fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  InputDecoration _fbInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF8D949E), fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFDDDFE2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF1877F2), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'National University',
                style: TextStyle(
                  color: Color(0xFF1877F2),
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                ),
              ),
              const Text(
                'Education that works.',
                style: TextStyle(
                  color: Color(0xFF65676B),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Log Into Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1C1E21),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: _fbInputDecoration('Email or phone number'),
                        validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _fbInputDecoration('Password'),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1877F2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.go('/forgot');
                            },
                            child: const Text(
                              'Forgot account?',
                              style: TextStyle(
                                color: Color(0xFF1877F2),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Text(
                            '·',
                            style: TextStyle(color: Color(0xFF65676B)),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/signup');
                            },
                            child: const Text(
                              'Sign up for account',
                              style: TextStyle(
                                color: Color(0xFF1877F2),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
