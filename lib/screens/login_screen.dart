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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const Color kGreen = Color(0xFF3DA843);
  static const Color kBrightGreen = Color(0xFF4CD137);
  static const Color kBg = Color(0xFF0B0F14);
  static const Color kFieldBg = Color(0xFF141A21);
  static const Color kFieldBorder = Color(0xFF2A3138);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          // ---- Background: stadium gradient + floodlight glows ----
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF05070A),
                    Color(0xFF0B0F14),
                    Color(0xFF0B0F14),
                  ],
                ),
              ),
            ),
          ),
          // Floodlight glow, top-left
          Positioned(
            top: -60,
            left: -60,
            child: _FloodlightGlow(),
          ),
          // Floodlight glow, top-right
          Positioned(
            top: -60,
            right: -60,
            child: _FloodlightGlow(),
          ),
          // Bottom green field glow with a soccer ball graphic
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _FieldFooter(),
          ),

          // ---- Foreground content ----
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // ---- Logo ----
                  Center(child: _Logo()),

                  const SizedBox(height: 28),

                  // ---- Title ----
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: 'Welcome '),
                        TextSpan(
                          text: 'Back!',
                          style: TextStyle(color: kBrightGreen),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to continue your football journey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9AA4AE),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ---- Email field ----
                  _InputField(
                    controller: _emailController,
                    hint: 'Email or Username',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  // ---- Password field ----
                  _InputField(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    trailing: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF9AA4AE),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---- Forgot password ----
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: navigate to forgot-password flow
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: kBrightGreen,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ---- Login button ----
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: hook up authentication logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ---- Divider ----
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.white.withOpacity(0.12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.white.withOpacity(0.12)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ---- Social buttons ----
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'Google',
                          icon: _googleIcon(),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          label: 'Apple',
                          icon: const Icon(Icons.apple,
                              color: Colors.white, size: 20),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          label: 'Facebook',
                          icon: const Icon(Icons.facebook,
                              color: Color(0xFF1877F2), size: 20),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ---- Sign up ----
                  Center(
                    child: Wrap(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF9AA4AE),
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: navigate to sign-up page
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: kBrightGreen,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationColor: kBrightGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 220), // reserve space for field footer
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _googleIcon() {
    // Simple 'G' badge to avoid external asset dependencies.
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      child: const Text(
        'G',
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontWeight: FontWeight.w900,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Circular soft glow used to mimic stadium floodlights.
class _FloodlightGlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}

/// Shield-shaped logo badge with a soccer ball icon and app name.
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CD137);
    return ClipPath(
      clipper: _ShieldClipper(),
      child: Container(
        width: 150,
        height: 170,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1319),
          border: Border.all(color: green, width: 2.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_soccer, color: Colors.white, size: 46),
            const SizedBox(height: 10),
            const Text(
              'FOOTBALL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
            const Text(
              'IQ',
              style: TextStyle(
                color: green,
                fontWeight: FontWeight.w900,
                fontSize: 24,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.55);
    path.quadraticBezierTo(w, h * 0.85, w / 2, h);
    path.quadraticBezierTo(0, h * 0.85, 0, h * 0.55);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Rounded dark text field with a leading icon and optional trailing widget.
class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.trailing,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF4CD137);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141A21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A3138)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF6B7480), fontSize: 15),
          prefixIcon: Icon(icon, color: green, size: 20),
          suffixIcon: trailing,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
        ),
      ),
    );
  }
}

/// Small rounded button used for social login providers.
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF141A21),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A3138)),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom decorative area mimicking the green pitch glow with a soccer ball.
class _FieldFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2E8B3B);
    return IgnorePointer(
      child: SizedBox(
        height: 220,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      green.withOpacity(0.25),
                      green.withOpacity(0.45),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.sports_soccer,
                    color: Colors.black87, size: 90),
              ),
            ),
          ],
        ),
      ),
    );
  }
}