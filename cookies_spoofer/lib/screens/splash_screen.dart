import 'package:cookies_spoofer/screens/cf_verify_screen.dart';
import 'package:cookies_spoofer/utils/checkCF.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isCloudflareProtected = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 2));
    isCloudflareProtected = await checkCloudflareProtection();
    if (isCloudflareProtected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CloudflareVerificationScreen()),
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    // Navigate to the main screen of your app
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
