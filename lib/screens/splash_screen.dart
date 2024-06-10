import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? title;
  String? subtitle;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadSplashData();
  }

  Future<void> _loadSplashData() async {
    final String response = await rootBundle.loadString('assets/splash_data.json');
    final data = await json.decode(response);
    setState(() {
      title = data['title'];
      subtitle = data['subtitle'];
      imagePath = data['image'];
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    await Future.delayed(Duration(seconds: 3)); // Simulate a delay

    if (seen) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed('/boarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath != null
                ? Image.asset(imagePath!)
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            title != null ? Text(title!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)) : Container(),
            SizedBox(height: 10),
            subtitle != null ? Text(subtitle!, style: TextStyle(fontSize: 16)) : Container(),
          ],
        ),
      ),
    );
  }
}
