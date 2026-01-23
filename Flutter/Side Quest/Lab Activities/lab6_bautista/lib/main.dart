import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B2E7D), // University Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const RegistrationScreen(),
    const StudentListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Registration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B2E7D),
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B2E7D), Color(0xFF0F1F4F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.school, size: 48, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Student Registration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.app_registration,
                color: Color(0xFFFFD700),
              ),
              title: const Text('Registration'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Color(0xFFFFD700)),
              title: const Text('List'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: const Color(0xFF1B2E7D),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registration',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        ],
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedCourse = 'BSIT';
  bool _isLoading = false;

  // IMPORTANT: Change this to your local IP address
  // Find your IP by running 'ipconfig' in command prompt (look for IPv4 Address)
  final String baseUrl = 'http://localhost/Flutter/lab6_bautista/php';

  @override
  void dispose() {
    _studentNumberController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _cpNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _registerStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a birthday')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'student_number': _studentNumberController.text,
          'name': _nameController.text,
          'birthday': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'course': _selectedCourse,
          'email': _emailController.text,
          'cp_number': _cpNumberController.text,
          'password': _passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            backgroundColor: data['success'] ? Colors.green : Colors.red,
          ),
        );

        if (data['success']) {
          _formKey.currentState!.reset();
          _studentNumberController.clear();
          _nameController.clear();
          _emailController.clear();
          _cpNumberController.clear();
          _passwordController.clear();
          setState(() {
            _selectedDate = null;
            _selectedCourse = 'BSIT';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // System Logo
                SvgPicture.network(
                  'https://upload.wikimedia.org/wikipedia/commons/9/90/NU_shield.svg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  placeholderBuilder: (context) {
                    return const Icon(
                      Icons.school,
                      size: 50,
                      color: Color(0xFF1B2E7D),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Student Registration System',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B2E7D),
                  ),
                ),
                const SizedBox(height: 30),

                // Student Number
                TextFormField(
                  controller: _studentNumberController,
                  decoration: InputDecoration(
                    labelText: 'Student Number',
                    labelStyle: const TextStyle(color: Color(0xFF1B2E7D)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B2E7D),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.badge,
                      color: Color(0xFF1B2E7D),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter student number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFD700),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Birthday
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Birthday',
                      labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                      style: TextStyle(
                        color: _selectedDate == null
                            ? Colors.grey
                            : const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Course Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  decoration: InputDecoration(
                    labelText: 'Course',
                    labelStyle: const TextStyle(color: Color(0xFF1B2E7D)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B2E7D),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.book,
                      color: Color(0xFF1B2E7D),
                    ),
                  ),
                  items: ['BSIT', 'BSCS'].map((String course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedCourse = newValue);
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFD700),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CP Number
                TextFormField(
                  controller: _cpNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Color(0xFF1B2E7D)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B2E7D),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Color(0xFF1B2E7D),
                    ),
                    hintText: '09123456789',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phone number';
                    }
                    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                      return 'Phone number must be exactly 11 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Color(0xFFFFD700)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFD700),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B2E7D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Register',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<dynamic> _students = [];
  bool _isLoading = true;

  // IMPORTANT: Change this to your local IP address
  final String baseUrl = 'http://localhost/Flutter/lab6_bautista/php';

  // Blue and Yellow avatar colors
  final List<Color> _colors = const [
    Color(0xFF1B2E7D),
    Color(0xFFFFD700),
    Color(0xFF1B2E7D),
    Color(0xFFFFD700),
    Color(0xFF1B2E7D),
    Color(0xFFFFD700),
    Color(0xFF1B2E7D),
    Color(0xFFFFD700),
  ];

  Color _getColorByIndex(int index) {
    return _colors[index % _colors.length];
  }

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(Uri.parse('$baseUrl/get_students.php'));

      final data = jsonDecode(response.body);

      if (data['success']) {
        setState(() {
          _students = data['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading students: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFF1B2E7D),
      onRefresh: _loadStudents,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B2E7D)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Logo
                    SvgPicture.network(
                      'https://upload.wikimedia.org/wikipedia/commons/9/90/NU_shield.svg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) {
                        return const Icon(
                          Icons.school,
                          size: 50,
                          color: Color(0xFF1B2E7D),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Student List',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B2E7D),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _students.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                Text(
                                  'No students registered yet',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _students.length,
                            itemBuilder: (context, index) {
                              final student = _students[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getColorByIndex(index),
                                    child: Text(
                                      student['name'][0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    student['name'],
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    student['course'],
                                    style: GoogleFonts.inter(),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        student['student_number'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
