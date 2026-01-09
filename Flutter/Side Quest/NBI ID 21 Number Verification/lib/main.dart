import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NBI Clearance Online Verification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFBB040)),
        useMaterial3: true,
      ),
      home: const NBIVerificationPage(),
    );
  }
}

class NBIVerificationPage extends StatefulWidget {
  const NBIVerificationPage({super.key});

  @override
  State<NBIVerificationPage> createState() => _NBIVerificationPageState();
}

class _NBIVerificationPageState extends State<NBIVerificationPage> {
  final TextEditingController _nbiIdController = TextEditingController();

  @override
  void dispose() {
    _nbiIdController.dispose();
    super.dispose();
  }

  void _showErrorModal(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B2B2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 32),
              SizedBox(width: 12),
              Text(
                'Error',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  void _verifyId() {
    // Verification logic would go here
    if (_nbiIdController.text.isEmpty) {
      _showErrorModal('Please enter NBI ID Number');
    } else if (_nbiIdController.text.length != 21) {
      _showErrorModal('NBI ID must be exactly 21 characters');
    } else {
      // Show success modal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2B2B2B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFFBB040), width: 2),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFFFBB040), size: 32),
                SizedBox(width: 12),
                Text(
                  'Verification Successful',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            content: Text(
              'NBI ID ${_nbiIdController.text} has been successfully verified.',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearField();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBB040),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _clearField() {
    _nbiIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: Column(
        children: [
          // Header with logo and yellow line
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // Maroon header (behind, stops at yellow line)
              Container(
                width: double.infinity,
                height: 62,
                color: const Color(0xFF5C1A1B),
              ),
              // Yellow line
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFFBB040),
                ),
              ),
              // Logo on top
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.asset(
                  'assets/images/nbi-logo.png',
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          // Main content
          Expanded(
            child: Center(
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    const Text(
                      'Enter NBI ID Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Input field
                    TextField(
                      controller: _nbiIdController,
                      maxLength: 21,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [LengthLimitingTextInputFormatter(21)],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFF4A4A4A),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFF4A4A4A),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFFFBB040),
                            width: 2,
                          ),
                        ),
                        suffixIcon: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBB040),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _verifyId,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFBB040),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _clearField,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFFBB040),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: Color(0xFFFBB040),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Center(
              child: Text(
                '© 2019 NBI Clearance Online Verification',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
