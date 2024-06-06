import 'package:abmfbnigeria/widgets/image_scroller.dart';
import 'package:abmfbnigeria/widgets/main_content.dart';
import 'package:flutter/material.dart';
import 'package:abmfbnigeria/constants/constants.dart';
import 'package:gap/gap.dart';

class LoginSignupPageMobile extends StatelessWidget {
  const LoginSignupPageMobile({
    super.key,
    required this.purpose,
  });

  final Purpose purpose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Fidelity Pension'),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    // onTap: () => _launchURL(),
                    child: Image.asset(
                      'assets/images/fidpen-logo.png',
                      height: 77,
                    ),
                  ),
                ),
                const Divider(
                  height: .2,
                ),
              ],
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 30.0, left: 30),
              child: ImageScroller(),
            ),
            SizedBox(
              width: 430,
              child: MainContent(
                purpose: purpose,
              ),
            )
          ],
        ),
      ),
    );
  }
}
