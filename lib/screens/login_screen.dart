import 'dart:math' as math;

import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
 
  @override
  State<LoginPage> createState() => _LoginPageState();
}
 
class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  bool obscurePassword = true;
 
  static const green = Color(0xFF35C94A);
  static const fieldColor = Color(0xFF101820);
  static const borderColor = Color(0xFF29333D);
  static const secondaryText = Color(0xFF9DA5AE);
 
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
 
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF02070B),
 
      body: Stack(
        children: [
          // ============================================================
          // BACKGROUND — cover instead of fill, so it never stretches
          // or distorts on screens with a different aspect ratio than
          // the reference design.
          // ============================================================
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
 
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.10)),
          ),
 
          // ============================================================
          // CONTENT — laid out with a Column + proportional spacing
          // instead of hard-coded pixel positions, so it adapts cleanly
          // to different phone sizes without clipping or big gaps.
          // ============================================================
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
 
                    // Logo
                    Image.asset(
                      'assets/images/football_iq_logo.png',
                      height: size.height * 0.16,
                      fit: BoxFit.contain,
                    ),
 
                    SizedBox(height: size.height * 0.03),
 
                    // Welcome text
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                        children: [
                          TextSpan(text: 'Welcome '),
                          TextSpan(text: 'Back!', style: TextStyle(color: green)),
                        ],
                      ),
                    ),
 
                    const SizedBox(height: 8),
 
                    Text(
                      'Login to continue your football journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: secondaryText, fontSize: 15),
                    ),
 
                    SizedBox(height: size.height * 0.045),
 
                    // Email field
                    _buildInputField(
                      controller: emailController,
                      hint: 'Email or Username',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),
 
                    const SizedBox(height: 16),
 
                    // Password field
                    _buildInputField(
                      controller: passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      obscure: obscurePassword,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() => obscurePassword = !obscurePassword);
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: secondaryText,
                          size: 22,
                        ),
                      ),
                    ),
 
                    const SizedBox(height: 10),
 
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
 
                    SizedBox(height: size.height * 0.035),
 
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
 
                    SizedBox(height: size.height * 0.035),
 
                    // Divider
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFF48505A))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 12,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFF48505A))),
                      ],
                    ),
 
                    SizedBox(height: size.height * 0.025),
 
                    // Social buttons
                    Row(
                      children: [
                        Expanded(
                          child: _socialButton(
                            icon: const Text(
                              'G',
                              style: TextStyle(
                                color: Color(0xFF4285F4),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            label: 'Google',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _socialButton(
                            icon: const Icon(Icons.apple, color: Colors.white, size: 22),
                            label: 'Apple',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _socialButton(
                            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 22),
                            label: 'Facebook',
                          ),
                        ),
                      ],
                    ),
 
                    SizedBox(height: size.height * 0.035),
 
                    // Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: secondaryText, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: green,
                            ),
                          ),
                        ),
                      ],
                    ),
 
                    const Spacer(),
 
                    // Football image — pinned to the bottom via Spacer
                    // above, instead of an absolute y-offset, so it never
                    // gets clipped on shorter screens.
                    Image.asset(
                      'assets/images/football.png',
                      height: size.height * 0.16,
                      fit: BoxFit.contain,
                    ),
 
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        cursorColor: green,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: secondaryText, fontSize: 16),
          prefixIcon: Icon(icon, color: green, size: 22),
          suffixIcon: suffix,
        ),
      ),
    );
  }
 
  Widget _socialButton({required Widget icon, required String label}) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}