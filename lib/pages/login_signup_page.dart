import 'package:flutter/material.dart';
import 'package:abmfbnigeria/constants/constants.dart';
import 'package:abmfbnigeria/pages/login_signup_page_desktop.dart';
import 'package:abmfbnigeria/pages/login_signup_page_mobile.dart';

class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({
    super.key,
    required this.purpose,
  });

  final Purpose purpose;

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.sizeOf(context).width;

    return totalWidth < desktopWidth
        ? LoginSignupPageMobile(
            purpose: purpose,
          )
        : LoginSignupPageDesktop(
            purpose: purpose,
          );
  }
}
