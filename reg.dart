import 'package:flutter/material.dart';
import 'package:grid/home/daraz.dart';

// ================== COLORS ==================
const Color kPrimary = Color(0xFF1A1A1A);
const Color kPink = Color(0xFF9E9E9E);
const Color kPinkLight = Color(0xFFF5F5F5);

const LinearGradient kPinkPurpleGradient = LinearGradient(
  colors: [Color(0xFF1A1A1A), Color(0xFF424242)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  bool obscure = true;

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  void register() {
    if (userController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty) return;

    if (!isValidEmail(emailController.text)) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DarazHome()),
    );
  }

  // ================= REUSABLE FIELD =================
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: kPrimary,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: kPinkLight,
        hintText: hint,
        prefixIcon: Icon(icon, color: kPrimary),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF424242), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // ================= LOGO =================
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 2),
                    ),
                    child: const Icon(Icons.person_add,
                        size: 52, color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  // ================= TITLE =================
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Register to get started",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ================= CARD =================
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        // ================= USERNAME =================
                        _buildField(
                          controller: userController,
                          hint: "Username",
                          icon: Icons.person,
                        ),

                        const SizedBox(height: 18),

                        // ================= EMAIL =================
                        _buildField(
                          controller: emailController,
                          hint: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 18),

                        // ================= PASSWORD =================
                        _buildField(
                          controller: passController,
                          hint: "Password",
                          icon: Icons.lock,
                          obscureText: obscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: kPrimary,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ================= REGISTER BUTTON =================
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: kPinkPurpleGradient,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: register,
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}