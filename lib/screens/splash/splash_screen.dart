import 'package:flutter/material.dart';
import 'package:team_soccer/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _loadLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen.init()));
    });
  }

  @override
  void initState() {
    _loadLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
