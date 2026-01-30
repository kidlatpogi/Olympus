import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _motherFirstNameController = TextEditingController();
  final TextEditingController _motherMiddleNameController = TextEditingController();
  final TextEditingController _motherLastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _selectedSex;
  String? _selectedCivilStatus;
  DateTime? _selectedDate;
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  
  final FirebaseService _firebaseService = FirebaseService();

  final List<String> _sexOptions = ['MALE', 'FEMALE'];
  final List<String> _civilStatusOptions = [
    'SINGLE',
    'MARRIED',
    'SEPARATED',
    'WIDOW',
    'DIVORCED',
    'ANNULLED',
    'WIDOWER',
    'SINGLE PARENT'
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF8B0000),
              onPrimary: Colors.white,
              surface: Color(0xFF2C0000),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use column layout for narrow screens, row for wide screens
          bool isNarrow = constraints.maxWidth < 900;
          
          if (isNarrow) {
            // Vertical layout for narrow screens
            return Column(
              children: [
                // Registration Form Section
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/NBI-BACKGROUND.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Color(0xFF391a1b),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: _buildRegistrationForm(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Horizontal layout for wide screens
            return Row(
              children: [
                // Registration Form Section
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/NBI-BACKGROUND.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          width: 600,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Color(0xFF391a1b),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: _buildRegistrationForm(),
                        ),
                      ),
                    ),
                  ),
                ),
                // Registered Users List Section
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xFF2C0000),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B0000),
                            border: Border(
                              bottom: BorderSide(color: Colors.amber, width: 2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.people, color: Colors.amber, size: 28),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'REGISTERED USERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _buildUsersList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'REGISTER AS FIRST TIME JOBSEEKER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Select Sex',
                  value: _selectedSex,
                  items: _sexOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedSex = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildDropdown(
                  label: 'Civil Status',
                  value: _selectedCivilStatus,
                  items: _civilStatusOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedCivilStatus = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildDatePicker(),
          SizedBox(height: 20),
          _buildTextField(
            controller: _firstNameController,
            label: 'First Name (Ex. DAVID JR, JOHN III)',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _middleNameController,
            label: 'Middle Name (Optional)',
            validator: (value) {
              return null; // Optional field
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _surnameController,
            label: 'Surname',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your surname';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Text(
            "Mother's Maiden Name",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _motherFirstNameController,
                  label: 'First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildTextField(
                  controller: _motherMiddleNameController,
                  label: 'Middle Name (Optional)',
                  validator: (value) {
                    return null; // Optional field
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildTextField(
                  controller: _motherLastNameController,
                  label: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _mobileController,
            label: 'Mobile Number (09XXXXXXXXX)',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              } else if (value.length != 11) {
                return 'Mobile number must be 11 digits';
              } else if (!value.startsWith('09')) {
                return 'Mobile number must start with 09';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _emailController,
            label: 'Enter new Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Email must contain @';
              } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPasswordField(
                  controller: _passwordController,
                  label: 'Enter new Password',
                  obscureText: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm new Password',
                  obscureText: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildCheckbox(),
          SizedBox(height: 30),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xFF5C0000),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amberAccent, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorStyle: TextStyle(color: Colors.white),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xFF460c0a),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFffa900), width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFffa900), width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFffa900), width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Color(0xFFffa900),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (label.contains('Confirm') && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xFF5C0000),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFffa900), width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFffa900), width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        errorStyle: TextStyle(color: Colors.white),
      ),
      dropdownColor: Color(0xFF460c0a),
      style: TextStyle(color: Colors.white),
      icon: Icon(Icons.arrow_drop_down, color: Color(0xFFffa900)),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _pickDate,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF460c0a),
          border: Border.all(color: Color(0xFFffa900), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _selectedDate != null
                    ? 'Birth Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'
                    : 'Birth Date',
                style: TextStyle(
                  color: _selectedDate != null ? Colors.white : Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.calendar_today, color: Color(0xFFffa900)),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return InkWell(
      onTap: () {
        setState(() {
          _acceptTerms = !_acceptTerms;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFF460c0a),
              border: Border.all(color: Color(0xFFffa900), width: 2),
            ),
            child: _acceptTerms
                ? Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
          SizedBox(width: 10),
          Text(
            'READ and ACCEPT ',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            'TERMS OF SERVICES',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _isLoading ? null : () async {
        if (_formKey.currentState?.validate() ?? false) {
          if (_selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select your birth date'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          if (!_acceptTerms) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please accept the terms of services'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          
          // Check if passwords match
          if (_passwordController.text != _confirmPasswordController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Passwords do not match!'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          
          // Show loading state
          setState(() {
            _isLoading = true;
          });
          
          // Register user with Firebase
          final result = await _firebaseService.registerUser(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            userData: {
              'firstName': _firstNameController.text,
              'middleName': _middleNameController.text,
              'surname': _surnameController.text,
              'sex': _selectedSex,
              'civilStatus': _selectedCivilStatus,
              'birthDate': _selectedDate!.toIso8601String(),
              'motherFirstName': _motherFirstNameController.text,
              'motherMiddleName': _motherMiddleNameController.text,
              'motherLastName': _motherLastNameController.text,
              'mobile': _mobileController.text,
            },
          );
          
          // Hide loading state
          setState(() {
            _isLoading = false;
          });
          
          if (result['success']) {
            // Show success dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Color(0xFF8B0000),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber, width: 3),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'REGISTRATION SUCCESSFUL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Your account has been created successfully!',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Name: ${_firstNameController.text} ${_middleNameController.text} ${_surnameController.text}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sex: $_selectedSex',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Civil Status: $_selectedCivilStatus',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Birth Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Mother's Maiden Name: ${_motherFirstNameController.text} ${_motherMiddleNameController.text} ${_motherLastNameController.text}",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mobile: ${_mobileController.text}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ${_emailController.text}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Clear form
                            _formKey.currentState?.reset();
                            _firstNameController.clear();
                            _middleNameController.clear();
                            _surnameController.clear();
                            _motherFirstNameController.clear();
                            _motherMiddleNameController.clear();
                            _motherLastNameController.clear();
                            _mobileController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                            setState(() {
                              _selectedSex = null;
                              _selectedCivilStatus = null;
                              _selectedDate = null;
                              _acceptTerms = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message']),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 4),
              ),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: _isLoading ? Colors.grey : Colors.amber,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: _isLoading
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              )
            : Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  Widget _buildUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading users',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off, color: Colors.white38, size: 64),
                SizedBox(height: 16),
                Text(
                  'No registered users yet',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            String userId = snapshot.data!.docs[index].id;
            String firstName = userData['firstName'] ?? '';
            String middleName = userData['middleName'] ?? '';
            String surname = userData['surname'] ?? '';
            String fullName = '$firstName ${middleName.isNotEmpty ? middleName + ' ' : ''}$surname';
            String email = userData['email'] ?? '';
            String mobile = userData['mobile'] ?? '';

            return Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF460c0a),
                border: Border.all(color: Color(0xFFffa900), width: 2),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.amber, size: 14),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            email,
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.amber, size: 14),
                        SizedBox(width: 6),
                        Text(
                          mobile,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    // Show confirmation dialog
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF8B0000),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.amber, width: 2),
                          ),
                          title: Text(
                            'Delete User',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            'Are you sure you want to delete $fullName?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'DELETE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      final result = await _firebaseService.deleteUser(userId);
                      if (result['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User deleted successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['message']),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _surnameController.dispose();
    _motherFirstNameController.dispose();
    _motherMiddleNameController.dispose();
    _motherLastNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
