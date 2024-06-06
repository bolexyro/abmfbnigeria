import 'package:abmfbnigeria/constants/constants.dart';
import 'package:abmfbnigeria/pages/login_signup_page.dart';
import 'package:abmfbnigeria/widgets/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    super.key,
    required this.purpose,
  });

  final Purpose purpose;

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  String? _enteredEmail;
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  String? _emailAddressSignInError;
  bool _isAuthenticating = false;

  void _login() async {
    _emailAddressSignInError = null;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isAuthenticating = true;
    });

    _formKey.currentState!.save();
    try {
      final db = FirebaseFirestore.instance;
      final user = <String, dynamic>{
        "email": _enteredEmail,
      };
      db.collection("users").add(user);
    } catch (e) {
      setState(() {
        _emailAddressSignInError = e.toString();
      });
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isAuthenticating = true;
    });

    _formKey.currentState!.save();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('signedUp', true);
      final db = FirebaseFirestore.instance;
      final user = <String, dynamic>{
        "email": _enteredEmail,
      };
      db.collection("users").add(user);

      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (context) => const MessageDialog(),
        );
      }
    } catch (e) {
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool('signedUp', true),
      );

      setState(() {
        _emailAddressSignInError = e.toString();
      });
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 90),
      child: Column(
        children: [
          const Gap(100),
          Image.asset(
            'assets/images/emoji.jpg',
            height: 150,
          ),
          const SizedBox(
            width: 240,
            child: Opacity(
              opacity: .5,
              child: Text(
                'Welcome to Fidelity Pension',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w100,
                  color: Color.fromARGB(255, 103, 106, 108),
                ),
              ),
            ),
          ),
          const Gap(7),
          const SizedBox(
            width: 300,
            child: Text(
              'We remain committed to providing you the best service at all times.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 103, 106, 108),
              ),
            ),
          ),
          const Gap(10),
          Text(
            widget.purpose == Purpose.forLogin
                ? 'Sign in to enjoy the experience.'
                : 'Sign up to start with us.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 103, 106, 108),
            ),
          ),
          const Gap(10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return 'Enter a valid email.';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _enteredEmail = newValue,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    errorText: _emailAddressSignInError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          if (widget.purpose == Purpose.forLogin)
            Row(
              children: [
                const Spacer(),
                const Text(
                  'Remember Me',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 103, 106, 108),
                  ),
                ),
                const Gap(10),
                Checkbox(
                  value: _rememberMe,
                  onChanged: (newRememberMe) => setState(() {
                    _rememberMe = newRememberMe!;
                  }),
                ),
                const Spacer(),
              ],
            ),
          const Gap(15),
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth * .9,
                child: ElevatedButton(
                  onPressed: () {
                    widget.purpose == Purpose.forLogin ? _login() : _signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 21, 51, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: !_isAuthenticating
                      ? Text(widget.purpose == Purpose.forLogin
                          ? 'Sign In'
                          : 'Sign up')
                      : LoadingAnimationWidget.discreteCircle(
                          color: const Color.fromARGB(255, 201, 255, 203),
                          secondRingColor:
                              const Color.fromARGB(255, 114, 171, 115),
                          thirdRingColor:
                              const Color.fromARGB(255, 20, 133, 24),
                          size: 20,
                        ),
                ),
              );
            },
          ),
          const Gap(10),
          Text(
            widget.purpose == Purpose.forLogin
                ? 'If this is your first time using iPension?'
                : 'Already have an account?',
            style: const TextStyle(
              fontSize: 11,
              color: Color.fromARGB(255, 136, 136, 136),
            ),
          ),
          const Gap(10),
          LayoutBuilder(builder: (context, constraints) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => widget.purpose == Purpose.forLogin
                        ? const LoginSignupPage(purpose: Purpose.forSignup)
                        : const LoginSignupPage(
                            purpose: Purpose.forLogin,
                          ),
                  ),
                ),
                child: SizedBox(
                  width: constraints.maxWidth * .9,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: const Color.fromARGB(255, 103, 106, 108),
                          width: .5),
                    ),
                    child: Center(
                        child: Text(
                      widget.purpose == Purpose.forLogin ? 'Sign up' : 'Log in',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 103, 106, 108),
                      ),
                    )),
                  ),
                ),
              ),
            );
          }),
          const Gap(10),
          const Text(
            'Powered by Fidelity Pension Managers Limited © 2024 #RetireHappily',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Color.fromARGB(255, 103, 106, 108),
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
