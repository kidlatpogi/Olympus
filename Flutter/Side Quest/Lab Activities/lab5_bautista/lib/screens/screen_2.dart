import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Fundamentals: GlobalKey tracks form state and validation status
  final _formKey = GlobalKey<FormState>();

  // Controllers for text input data
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  DateTime? _selectedDate;
  String? _selectedSex;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Fundamentals: Dispose controllers to prevent memory leaks
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Helpers ---

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1877F2)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _handleSignUp() {
    debugPrint('=== BEFORE VALIDATION ===');
    debugPrint('Password Controller Text: "${_passwordController.text}"');

    // Triggers all validators; errors will appear at the bottom of fields
    if (_formKey.currentState!.validate()) {
      debugPrint('=== AFTER VALIDATION ===');
      debugPrint('Password Controller Text: "${_passwordController.text}"');

      if (_selectedDate == null || _selectedSex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your Birthday and Sex')),
        );
        return;
      }
      // Save data to local storage and show modal
      _saveUserData();
    }
  }

  Future<void> _saveUserData() async {
    // Debug: Print controller values before saving
    debugPrint('=== SIGNUP DEBUG ===');
    debugPrint('First Name: "${_firstNameController.text}"');
    debugPrint('Last Name: "${_lastNameController.text}"');
    debugPrint('Email: "${_emailController.text}"');
    debugPrint('Password: "${_passwordController.text}"');
    debugPrint('Birthday: "$_selectedDate"');
    debugPrint('Sex: "$_selectedSex"');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', _firstNameController.text.trim());
    await prefs.setString('last_name', _lastNameController.text.trim());
    await prefs.setString('user_email', _emailController.text.trim());
    await prefs.setString('user_password', _passwordController.text.trim());
    await prefs.setString('birthday', _selectedDate.toString());
    await prefs.setString('sex', _selectedSex ?? '');

    // Debug: Verify what was saved
    debugPrint('=== SAVED TO PREFS ===');
    debugPrint('Saved Email: "${prefs.getString('user_email')}"');
    debugPrint('Saved Password: "${prefs.getString('user_password')}"');

    // Show confirmation modal
    _showSignUpModal();
  }

  void _showSignUpModal() {
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
                  'Sign Up Successful!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1877F2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Account Information',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF606770),
                  ),
                ),
                const SizedBox(height: 12),
                _buildModalInfoRow('First Name:', _firstNameController.text),
                const SizedBox(height: 10),
                _buildModalInfoRow('Last Name:', _lastNameController.text),
                const SizedBox(height: 10),
                _buildModalInfoRow(
                  'Birthday:',
                  _selectedDate != null
                      ? '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}'
                      : 'Not selected',
                ),
                const SizedBox(height: 10),
                _buildModalInfoRow('Sex:', _selectedSex ?? 'Not selected'),
                const SizedBox(height: 10),
                _buildModalInfoRow('Email/Mobile:', _emailController.text),
                const SizedBox(height: 10),
                _buildModalInfoRow('Password:', _passwordController.text),
                const SizedBox(height: 20),
                const Text(
                  'Your data has been securely saved in local storage.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF65676B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/main');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A400),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
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
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/login');
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(color: Color(0xFF1877F2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalInfoRow(String label, String value) {
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

  // --- UI Building Blocks ---

  InputDecoration _fbInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF8D949E), fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      fillColor: const Color(0xFFF5F6F7),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xFFCCD0D5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xFF1877F2), width: 1),
      ),
      // Validations: Defines how errors look at the bottom of the field
      errorStyle: const TextStyle(fontSize: 10, color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 432,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'National University',
                  style: TextStyle(
                    color: Color(0xFF1877F2),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Create a new account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "It's quick and easy.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF606770),
                            fontSize: 13,
                          ),
                        ),
                        const Divider(height: 20, thickness: 1),

                        // Name Fields Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: _fbInputDecoration('First name'),
                                validator: (v) =>
                                    v!.isEmpty ? 'First name required' : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: _fbInputDecoration('Last name'),
                                validator: (v) =>
                                    v!.isEmpty ? 'Last name required' : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        _buildSectionLabel('Birthday'),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFCCD0D5),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'Select Date'
                                      : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Color(0xFF606770),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        _buildSectionLabel('Sex'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(child: _buildSexBox('Female')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildSexBox('Male')),
                          ],
                        ),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _emailController,
                          decoration: _fbInputDecoration(
                            'Mobile number or email',
                          ),
                          validator: (v) =>
                              v!.isEmpty ? 'Email or mobile required' : null,
                        ),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: _fbInputDecoration('New password'),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Password is required';
                            }
                            if (v.length < 8) {
                              return 'Password must be 8+ chars';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // Exact Legal Text
                        const Text(
                          'People who use our service may have uploaded your contact information to National University. Learn more.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF777777),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'By clicking Sign Up, you agree to our Terms, Privacy Policy and Cookies Policy. You may receive SMS Notifications from us and can opt out any time.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF777777),
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: SizedBox(
                            width: 180,
                            child: ElevatedButton(
                              onPressed: _handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00A400),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Color(0xFF1877F2),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 11, color: Color(0xFF606770)),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.help, size: 12, color: Color(0xFF606770)),
      ],
    );
  }

  Widget _buildSexBox(String value) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCD0D5)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: RadioListTile<String>(
        title: Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        value: value,
        groupValue: _selectedSex,
        contentPadding: const EdgeInsets.only(left: 4),
        dense: true,
        activeColor: const Color(0xFF1877F2),
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: (v) => setState(() => _selectedSex = v),
      ),
    );
  }
}
