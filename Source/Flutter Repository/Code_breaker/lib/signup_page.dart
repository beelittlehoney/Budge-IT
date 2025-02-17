import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showCredentials = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _birthdateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      if (!_showCredentials) {
        // If the user has not filled all required fields in the first step
        if (_nameController.text.isEmpty ||
            _ageController.text.isEmpty ||
            _phoneController.text.isEmpty ||
            _birthdateController.text.isEmpty ||
            _emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all required fields.')),
          );
          return;
        }
      } else {
        // Add any specific validation for second step fields here
        if (_usernameController.text.isEmpty ||
            _passwordController.text.isEmpty ||
            _confirmPasswordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all required fields.')),
          );
          return;
        }
      }

      setState(() {
        _showCredentials = !_showCredentials;
      });
    }
  }

  Future<void> _selectBirthdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthdateController.text = "${pickedDate.year.toString().padLeft(4, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF242424)),
        child: Center(
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Form(
                key: _formKey,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Create Your Account",
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Sign up to get started",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      if (!_showCredentials) ...[
                        CustomInputField(controller: _nameController, label: 'Name', hint: 'Enter your name', obscureText: false, icon: Icons.person),
                        const SizedBox(height: 20),
                        CustomInputField(controller: _ageController, label: 'Age', hint: 'Enter your age', obscureText: false, icon: Icons.calendar_today),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.wc, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: ['Male', 'Female', 'Prefer not to say'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(controller: _phoneController, label: 'Phone Number', hint: '+63', obscureText: false, icon: Icons.phone),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _birthdateController,
                          decoration: InputDecoration(
                            labelText: 'Birthdate',
                            hintText: 'Select your birthdate',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          readOnly: true,
                          onTap: () => _selectBirthdate(context),
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(controller: _emailController, label: 'Email', hint: 'Enter your email address', obscureText: false, icon: Icons.email),
                        const SizedBox(height: 30),
                      ] else ...[
                        CustomInputField(controller: _usernameController, label: 'Username', hint: 'Enter your username', obscureText: false, icon: Icons.alternate_email),
                        const SizedBox(height: 20),
                        CustomInputField(controller: _passwordController, label: 'Password', hint: 'Enter your password', obscureText: true, icon: Icons.lock),
                        const SizedBox(height: 20),
                        CustomInputField(controller: _confirmPasswordController, label: 'Confirm Password', hint: 'Re-enter your password', obscureText: true, icon: Icons.lock),
                        const SizedBox(height: 30),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: FaIcon(FontAwesomeIcons.google, color: Colors.white), onPressed: () {}),
                          SizedBox(width: 20),
                          IconButton(icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white), onPressed: () {}),
                          SizedBox(width: 20),
                          IconButton(icon: FaIcon(FontAwesomeIcons.apple, color: Colors.white), onPressed: () {}),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _validateAndProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _showCredentials ? 'Sign Up' : 'Next',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
