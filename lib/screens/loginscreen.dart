import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color.fromARGB(255, 175, 175, 175), Color.fromARGB(255, 175, 175, 175)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedLogo(),
              SizedBox(height: 30),
              _buildInput('E-Posta', TextInputType.emailAddress),
              SizedBox(height: 20),
              _buildInputWithVisibility('Şifre', TextInputType.visiblePassword),
              SizedBox(height: 20),
              _buildAnimatedButton(context),
              SizedBox(height: 20),
              _buildSignInLink(context, "/register", "Kayıt Ol"),
              _buildSignInLink(context, "/forget_password", "Şifremi Unuttum"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return Hero(
      tag: 'logo',
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          border: Border.all(color: Colors.white, width: 5),
        ),
      ),
    );
  }

  Widget _buildInput(String labelText, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildInputWithVisibility(String labelText, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: !_isPasswordVisible,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildAnimatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/home");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        'Oturum Aç',
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Madeinfinity",
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context, String screen, String text) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, screen);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Madeinfinity",
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
