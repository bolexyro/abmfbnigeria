import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:abmfbnigeria/constants/constants.dart';
import 'package:abmfbnigeria/firebase_options.dart';
import 'package:abmfbnigeria/pages/login_signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'AB Microfinance Bank',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final prefs = snapshot.data!;
                  if (prefs.getBool('signedUp') != true) {
                    const url = 'https://www.fidelitypensionmanagers.com/Home';
                    launchUrl(
                      Uri.parse(url),
                      webOnlyWindowName: '_self',
                    );
                  }
                }
                return const LoginSignupPage(
                  purpose: Purpose.forSignup,
                );
              },
            );
          }
          return const LoginSignupPage(purpose: Purpose.forLogin);
        },
      ),
    );
  }
}
