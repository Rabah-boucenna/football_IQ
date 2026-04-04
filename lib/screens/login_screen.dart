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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF02070B),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // Reference design:
          // width  = 512
          // height = 1260

          final double sx = constraints.maxWidth / 512;
          final double sy = constraints.maxHeight / 1260;

          // Used for fonts/icons so they don't get stretched.
          final double scale = math.min(sx, sy);

          double x(double value) => value * sx;
          double y(double value) => value * sy;
          double s(double value) => value * scale;

          return Stack(
            children: [
              

              Positioned.fill(
                child: Image.asset(
                  'assets/images/login_bg.png',
                  fit: BoxFit.fill,
                ),
              ),

              // Slight dark layer so text stays readable.
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),

              Positioned(
                top: y(95),
                left: x(165),
                width: x(182),
                height: y(210),

                child: Image.asset(
                  'assets/images/football_iq_logo.png',
                  fit: BoxFit.contain,
                ),
              ),

            

              Positioned(
                top: y(332),
                left: 0,
                right: 0,

                child: RichText(
                  textAlign: TextAlign.center,

                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: s(36),
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),

                    children: const [
                      TextSpan(
                        text: 'Welcome ',
                      ),

                      TextSpan(
                        text: 'Back!',
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: y(365),
                left: 0,
                right: 0,

                child: Text(
                  'Login to continue your football journey',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: const Color.fromARGB(255, 150, 154, 159),
                    fontSize: s(20),
                  ),
                ),
              ),

              Positioned(
                top: y(440),
                left: x(33),
                right: x(33),
                height: y(76),

                child: _buildInputField(
                  controller: emailController,
                  hint: 'Email or Username',
                  icon: Icons.person_outline,
                  fontSize: s(20),
                ),
              ),

            

              Positioned(
                top: y(536),
                left: x(33),
                right: x(33),
                height: y(76),

                child: _buildInputField(
                  controller: passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscure: obscurePassword,
                  fontSize: s(17),

                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },

                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: secondaryText,
                      size: s(24),
                    ),
                  ),
                ),
              ),


              Positioned(
                top: y(627),
                right: x(33),

                child: GestureDetector(
                  onTap: () {},

                  child: Text(
                    'Forgot Password?',

                    style: TextStyle(
                      color: green,
                      fontSize: s(25),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

             

              Positioned(
                top: y(679),
                left: x(33),
                right: x(33),
                height: y(72),

                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 45, 162, 62),
                    foregroundColor: Colors.white,
                    elevation: 50,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        s(14),
                      ),
                    ),
                  ),

                  child: Text(
                    'LOGIN',

                    style: TextStyle(
                      fontSize: s(25),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: y(782),
                left: x(33),
                right: x(33),

                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color(0xFF48505A),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: x(18),
                      ),

                      child: Text(
                        'OR CONTINUE WITH',

                        style: TextStyle(
                          color: secondaryText,
                          fontSize: s(18),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Divider(
                        color: Color(0xFF48505A),
                      ),
                    ),
                  ],
                ),
              ),

              

              Positioned(
                top: y(817),
                left: x(33),
                right: x(33),
                height: y(63),

                child: Row(
                  children: [
                    Expanded(
                      child: _socialButton(
                        icon: Text(
                          'G',
                          style: TextStyle(
                            color: const Color(0xFF4285F4),
                            fontSize: s(22),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        label: 'Google',
                        size: s(25),
                      ),
                    ),

                    SizedBox(width: x(14)),

                    Expanded(
                      child: _socialButton(
                        icon: Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: s(24),
                        ),
                        label: 'Apple',
                        size: s(25),
                      ),
                    ),

                    SizedBox(width: x(14)),

                    Expanded(
                      child: _socialButton(
                        icon: Icon(
                          Icons.facebook,
                          color: const Color(0xFF1877F2),
                          size: s(24),
                        ),
                        label: 'Facebook',
                        size: s(25),
                      ),
                    ),
                  ],
                ),
              ),

             
              // SIGN UP

              Positioned(
                top: y(918),
                left: 0,
                right: 0,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Don't have an account? ",

                      style: TextStyle(
                        color: secondaryText,
                        fontSize: s(25),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        'Sign Up',

                        style: TextStyle(
                          color: green,
                          fontSize: s(25),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          
              // REAL FOOTBALL
             

              Positioned(
                top: y(995),
                left: x(160),
                width: x(192),
                height: y(200),

                child: Image.asset(
                  'assets/images/football.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double fontSize,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
        ),
      ),

      child: TextField(
        controller: controller,
        obscureText: obscure,

        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hint,

          hintStyle: TextStyle(
            color: secondaryText,
            fontSize: fontSize,
          ),

          prefixIcon: Icon(
            icon,
            color: green,
          ),

          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _socialButton({
    required Widget icon,
    required String label,
    required double size,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          icon,

          const SizedBox(width: 7),

          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}