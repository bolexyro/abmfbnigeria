import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:abmfbnigeria/constants/constants.dart';
import 'package:abmfbnigeria/pages/login_signup_page.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        width: 400,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 143, 224, 57),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fidpen-logo.png',
                    height: 70,
                  ),
                  const Text(
                    'Awesome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Your account has been created',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(15),
                ],
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginSignupPage(
                        purpose: Purpose.forLogin,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 143, 224, 57),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Take me to login'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
