import 'dart:async';

import 'package:abmfbnigeria/widgets/image_scroller.dart';
import 'package:abmfbnigeria/widgets/main_content.dart';
import 'package:abmfbnigeria/widgets/review_card_scroller.dart';

import 'package:flutter/material.dart';
import 'package:abmfbnigeria/constants/constants.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginSignupPageDesktop extends StatefulWidget {
  const LoginSignupPageDesktop({
    super.key,
    required this.purpose,
  });

  final Purpose purpose;

  @override
  State<LoginSignupPageDesktop> createState() => _LoginSignupPageDesktopState();
}

class _LoginSignupPageDesktopState extends State<LoginSignupPageDesktop>
    with TickerProviderStateMixin {
  // Function to launch a URL in the web browser
  Future<void> _launchURL() async {
    const url = 'https://ab-mfbnigeria.com/';
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: '_self',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchURL(),
                    child: Image.asset(
                      'assets/images/ab-logo.jpg',
                      height: 77,
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchURL(),
                    child: Image.asset(
                      'assets/images/cbn-logo.png',
                      height: 77,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: .2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    children: [
                      Gap(20),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20, right: 30.0, left: 30),
                        child: ImageScroller(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .329,
                  child: MainContent(
                    purpose: widget.purpose,
                  ),
                )
              ],
            ),
            const ReviewCardScroller(),

             RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'What people say about ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'AB Microfinance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kBlueColor,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
