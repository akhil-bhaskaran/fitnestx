import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fitness/pages/dashboard/main_dashboard.dart';

import 'package:fitness/pages/signup_and_in/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ProfileCompletionPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return MainDashboardPage();
          }

          // If not logged in, show Register Page
          return Signup();
        },
      ),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: -.7,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w200,
            letterSpacing: -.5,
            fontSize: 15,
          ),
          titleMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 30,
            letterSpacing: -.7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
