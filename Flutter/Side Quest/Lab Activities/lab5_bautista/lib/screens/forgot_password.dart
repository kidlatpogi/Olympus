import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _searchController = TextEditingController();
  bool _accountFound = false;
  String? _foundEmail;
  String? _foundFirstName;
  String? _foundLastName;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchAccount() async {
    final searchValue = _searchController.text.trim();

    if (searchValue.isEmpty) {
      _showErrorDialog(
        'Empty Field',
        'Please enter an email or mobile number.',
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('user_email');
    final firstName = prefs.getString('first_name');
    final lastName = prefs.getString('last_name');

    // Check if account exists
    if (storedEmail == searchValue) {
      setState(() {
        _accountFound = true;
        _foundEmail = storedEmail;
        _foundFirstName = firstName;
        _foundLastName = lastName;
      });
    } else {
      _showErrorDialog(
        'Account Not Found',
        'No account found with this email or mobile number.',
      );
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(title),
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

  void _resetPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final newPasswordController = TextEditingController();
        final confirmPasswordController = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your new password:'),
              const SizedBox(height: 12),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'New password (min 8 characters)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F6F7),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Confirm password:'),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F6F7),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newPassword = newPasswordController.text;
                final confirmPassword = confirmPasswordController.text;

                if (newPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password is required')),
                  );
                  return;
                }

                if (newPassword.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password must be at least 8 characters'),
                    ),
                  );
                  return;
                }

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                // Update password in local storage
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('user_password', newPassword);

                if (mounted) {
                  Navigator.pop(context); // Close reset dialog
                  _showSuccessDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset Password'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Password Reset Successfully',
            style: TextStyle(color: Color(0xFF00A400)),
          ),
          content: const Text(
            'Your password has been updated. Please log in with your new password.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Back to Login'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _fbInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF8D949E), fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFDDDFE2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF1877F2), width: 1),
      ),
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
              const SizedBox(height: 20),
              Container(
                width: 400,
                padding: const EdgeInsets.all(24),
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
                child: _accountFound
                    ? _buildAccountFoundView()
                    : _buildFindAccountView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFindAccountView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Find your account',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please enter your email or mobile number to search for your account.',
          style: TextStyle(fontSize: 14, color: Color(0xFF606770)),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _searchController,
          decoration: _fbInputDecoration('Email or mobile number'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.go('/login'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFFDDDFE2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1877F2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _searchAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1877F2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountFoundView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Account Found',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00A400),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F7),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFCCD0D5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Information:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1877F2),
                ),
              ),
              const SizedBox(height: 12),
              Text('Name: $_foundFirstName $_foundLastName'),
              const SizedBox(height: 8),
              Text('Email: $_foundEmail'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _resetPassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1877F2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Reset Password',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            setState(() {
              _accountFound = false;
              _searchController.clear();
            });
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: const BorderSide(color: Color(0xFFDDDFE2)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Search Again',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1877F2),
            ),
          ),
        ),
      ],
    );
  }
}
