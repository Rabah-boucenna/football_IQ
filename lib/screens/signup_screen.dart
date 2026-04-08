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
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  // CONTROLLERS
  

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();


  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool acceptedTerms = false;

 

  static const Color green = Color(0xFF35C94A);
  static const Color fieldColor = Color(0xFF101820);
  static const Color borderColor = Color(0xFF29333D);
  static const Color secondaryText = Color(0xFF9DA5AE);

  
  // PASSWORD VALIDATION
  

  bool get passwordIsValid {
  final String password = passwordController.text;

  final bool hasMinLength = password.length >= 8;
  final bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  final bool hasNumber = RegExp(r'[0-9]').hasMatch(password);
  final bool hasSpecialCharacter =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  return hasMinLength &&
      hasUppercase &&
      hasLowercase &&
      hasNumber &&
      hasSpecialCharacter;
}

  bool get passwordsMatch {
    return confirmPasswordController.text.isNotEmpty &&
        passwordController.text ==
            confirmPasswordController.text;
  }


  

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keep the complete design on one page.
      resizeToAvoidBottomInset: false,

      backgroundColor: const Color(0xFF02070B),

      body: GestureDetector(
        // Clicking outside of a field hides the keyboard.
        onTap: () {
          FocusScope.of(context).unfocus();
        },

        child: LayoutBuilder(
          builder: (context, constraints) {
            // ==================================================
            // REFERENCE DESIGN SIZE
            //
            // We use the same coordinate system as LoginPage.
            // Everything automatically scales to the phone.
            // ==================================================

            final double sx =
                constraints.maxWidth / 512;

            final double sy =
                constraints.maxHeight / 1260;

            // Fonts and icons use the smallest scale so they
            // don't become stretched.
            final double scale =
                math.min(sx, sy);

            double x(double value) => value * sx;
            double y(double value) => value * sy;
            double s(double value) => value * scale;

            return Stack(
              children: [
                
                // BACKGROUND
                

                Positioned.fill(
                  child: Opacity(
                    opacity: 0.90,

                    child: Image.asset(
                      'assets/images/login_bg.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                // Slight dark layer to make the UI easier to read.
                Positioned.fill(
                  child: Container(
                    color:
                        Colors.black.withOpacity(0.15),
                  ),
                ),

                
                // LOGO
                

                Positioned(
                  top: y(40),
                  left: x(174),
                  width: x(164),
                  height: y(180),

                  child: Image.asset(
                    'assets/images/football_iq_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                
                // TITLE
                

                Positioned(
                  top: y(235),
                  left: 0,
                  right: 0,

                  child: RichText(
                    textAlign: TextAlign.center,

                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,

                        // Same title size as login.
                        fontSize: s(33),

                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),

                      children: const [
                        TextSpan(
                          text: 'Create ',
                        ),

                        TextSpan(
                          text: 'Account!',
                          style: TextStyle(
                            color: green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                
                // SUBTITLE
                

                Positioned(
                  top: y(278),
                  left: 0,
                  right: 0,

                  child: Text(
                    'Sign up to start your football journey',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: const Color.fromARGB(
                        255,
                        202,
                        202,
                        202,
                      ),

                      // Same subtitle size as login.
                      fontSize: s(20),

                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                
                // USERNAME
                

                Positioned(
                  top: y(335),
                  left: x(33),
                  right: x(33),
                  height: y(70),

                  child: _buildInputField(
                    controller: usernameController,

                    hint: 'Username',

                    icon: Icons.person_outline,

                    // Same input font size as login.
                    fontSize: s(24),
                  ),
                ),

                
                // EMAIL
                

                Positioned(
                  top: y(420),
                  left: x(33),
                  right: x(33),
                  height: y(70),

                  child: _buildInputField(
                    controller: emailController,

                    hint: 'Email',

                    icon: Icons.mail_outline,

                    fontSize: s(24),

                    keyboardType:
                        TextInputType.emailAddress,
                  ),
                ),

                
                // PASSWORD
                

                Positioned(
                  top: y(505),
                  left: x(33),
                  right: x(33),
                  height: y(70),

                  child: _buildInputField(
                    controller: passwordController,

                    hint: 'Password',

                    icon: Icons.lock_outline,

                    obscure: obscurePassword,

                    fontSize: s(24),

                    // Re-check password requirements while typing.
                    onChanged: (_) {
                      setState(() {});
                    },

                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },

                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons
                                .visibility_off_outlined,

                        color: secondaryText,

                        size: s(24),
                      ),
                    ),
                  ),
                ),

                
                // PASSWORD REQUIREMENTS
                

               
                
                // CONFIRM PASSWORD
                

                Positioned(
                  top: y(599),
                  left: x(33),
                  right: x(33),
                  height: y(70),

                  child: _buildInputField(
                    controller:
                        confirmPasswordController,

                    hint: 'Confirm Password',

                    icon: Icons.lock_outline,

                    obscure:
                        obscureConfirmPassword,

                    fontSize: s(24),

                    // Update match indicator while typing.
                    onChanged: (_) {
                      setState(() {});
                    },

                    // We need both the eye icon and match icon.
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              obscureConfirmPassword =
                                  !obscureConfirmPassword;
                            });
                          },

                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons
                                    .visibility_outlined
                                : Icons
                                    .visibility_off_outlined,

                            color: secondaryText,

                            size: s(24),
                          ),
                        ),

                        // Show the match state only once the user
                        // has typed something.
                        if (confirmPasswordController
                            .text
                            .isNotEmpty)
                          Padding(
                            padding:
                                EdgeInsets.only(
                              right: x(10),
                            ),

                            child: Icon(
                              passwordsMatch
                                  ? Icons
                                      .check_circle_outline
                                  : Icons
                                      .cancel_outlined,

                              color: passwordsMatch
                                  ? green
                                  : Colors.redAccent,

                              size: s(25),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                
                // TERMS & PRIVACY
                

                Positioned(
                  top: y(705),
                  left: x(50),
                  right: x(33),

                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,

                    children: [
                      // Custom checkbox.
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            acceptedTerms =
                                !acceptedTerms;
                          });
                        },

                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 150,
                          ),

                          width: s(25),
                          height: s(25),

                          decoration: BoxDecoration(
                            color: acceptedTerms
                                ? green
                                : Colors.transparent,

                            borderRadius:
                                BorderRadius.circular(
                              s(5),
                            ),

                            border: Border.all(
                              color: green,
                              width: 1.0,
                            ),
                          ),

                          child: acceptedTerms
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: s(18),
                                )
                              : null,
                        ),
                      ),

                      SizedBox(
                        width: x(12),
                      ),

                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: s(20),
                            ),

                            children: const [
                              TextSpan(
                                text:
                                    'By signing up, you agree to our ',
                              ),

                              TextSpan(
                                text:
                                    'Terms & Privacy Policy',

                                style: TextStyle(
                                  color: green,
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                
                // SIGN UP BUTTON
                

                Positioned(
                  top: y(775),
                  left: x(33),
                  right: x(33),
                  height: y(72),

                  child: ElevatedButton(
                    onPressed: () {
                      // Authentication will be connected later.
                      //
                      // Later we'll check:
                      // 1. Email is valid
                      // 2. Password is valid
                      // 3. Passwords match
                      // 4. Terms are accepted
                      // 5. Firebase sign-up succeeds
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(
                        255,
                        29,
                        129,
                        44,
                      ),

                      foregroundColor:
                          Colors.white,

                      elevation: 5,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          s(14),
                        ),
                      ),
                    ),

                    child: Text(
                      'SIGN UP',

                      style: TextStyle(
                        // Same button text size
                        // as the login button.
                        fontSize: s(25),

                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                
                // OR SIGN UP WITH
                

                Positioned(
                  top: y(875),
                  left: x(33),
                  right: x(33),

                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color:
                              Color(0xFF48505A),
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(
                          horizontal: x(18),
                        ),

                        child: Text(
                          'OR SIGN UP WITH',

                          style: TextStyle(
                            color:
                                secondaryText,

                            // Same divider text size
                            // as login screen.
                            fontSize: s(18),
                          ),
                        ),
                      ),

                      const Expanded(
                        child: Divider(
                          color:
                              Color(0xFF48505A),
                        ),
                      ),
                    ],
                  ),
                ),

                
                // SOCIAL LOGIN BUTTONS
                

                Positioned(
                  top: y(915),
                  left: x(33),
                  right: x(33),
                  height: y(63),

                  child: Row(
                    children: [
                      Expanded(
                        child:
                            _socialButton(
                          icon: Text(
                            'G',

                            style: TextStyle(
                              color:
                                  const Color(
                                0xFF4285F4,
                              ),

                              fontSize:
                                  s(22),

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          label:
                              'Google',

                          size: s(25),
                        ),
                      ),

                      SizedBox(
                        width: x(14),
                      ),

                      Expanded(
                        child:
                            _socialButton(
                          icon: Icon(
                            Icons.apple,

                            color:
                                Colors.white,

                            size: s(24),
                          ),

                          label: 'Apple',

                          size: s(25),
                        ),
                      ),

                      SizedBox(
                        width: x(14),
                      ),

                      Expanded(
                        child:
                            _socialButton(
                          icon: Icon(
                            Icons.facebook,

                            color:
                                const Color(
                              0xFF1877F2,
                            ),

                            size: s(24),
                          ),

                          label:
                              'Facebook',

                          size: s(25),
                        ),
                      ),
                    ],
                  ),
                ),

                
                // ALREADY HAVE AN ACCOUNT

                Positioned(
                  top: y(1015),
                  left: 0,
                  right: 0,

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      Text(
                        'Already have an account? ',

                        style: TextStyle(
                          color:
                              secondaryText,

                          fontSize: s(23),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          // Later:
                          //
                          // Navigator.pop(context);
                          //
                          // if SignupPage was opened
                          // from LoginPage.
                        },

                        child: Text(
                          'Login',

                          style: TextStyle(
                            color: green,

                            fontSize: s(23),

                            fontWeight:
                                FontWeight.w600,

                            decoration:
                                TextDecoration
                                    .underline,

                            decorationColor:
                                green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                
                // FOOTBALL
                

                Positioned(
                  top: y(1070),
                  left: x(165),
                  width: x(182),
                  height: y(180),

                  // Slight darkening makes the ball fit
                  // the dark stadium atmosphere better.
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(
                      Colors.black
                          .withOpacity(0.10),

                      BlendMode.darken,
                    ),

                    child: Image.asset(
                      'assets/images/football.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  
  // INPUT FIELD
  

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double fontSize,

    bool obscure = false,

    Widget? suffix,

    ValueChanged<String>? onChanged,

    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(0.94),

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: borderColor,
        ),
      ),

      child: TextField(
        controller: controller,

        obscureText: obscure,

        keyboardType: keyboardType,

        onChanged: onChanged,

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

  
  // SOCIAL BUTTON
  

  Widget _socialButton({
    required Widget icon,
    required String label,
    required double size,
  }) {
    return InkWell(
      onTap: () {
        // Google / Apple / Facebook auth later.
      },

      borderRadius:
          BorderRadius.circular(12),

      child: Container(
        decoration: BoxDecoration(
          color:
              fieldColor.withOpacity(0.94),

          borderRadius:
              BorderRadius.circular(12),

          border: Border.all(
            color: borderColor,
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            icon,

            const SizedBox(
              width: 7,
            ),

            Flexible(
              child: Text(
                label,

                overflow:
                    TextOverflow.ellipsis,

                style: TextStyle(
                  color: Colors.white,

                  fontSize: size,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}