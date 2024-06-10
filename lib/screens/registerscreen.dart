import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterScreen(),
  ));
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: buildColumn(context),
        ),
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildAnimatedLogo(),
        SizedBox(height: 30),
        buildInput('Kullanıcı Adı'),
        SizedBox(height: 10),
        buildInput('E-Posta'),
        SizedBox(height: 10),
        buildInputWithVisibility('Şifre'),
        SizedBox(height: 10),
        buildInputWithVisibility('Tekrar Şifre'),
        SizedBox(height: 20),
        buildButtons(context),
        SizedBox(height: 20),
        buildSignInLink(context, "/LoginScreen", "Oturum Aç"),
      ],
    );
  }

  Widget buildAnimatedLogo() {
    return Hero(
      tag: 'logo',
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          border: Border.all(color: Colors.white, width: 5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('assets/images/logos/logoiki2.png'),
          ),
        ),
      ),
    );
  }

  Widget buildInput(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextFormField(
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

  Widget buildInputWithVisibility(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextFormField(
        obscureText: true,
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
            onTap: () {},
            child: Icon(
              Icons.visibility,
              color: Colors.white,
            ),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Kayıt işlemi burada yapılacak
        // Başarıyla kayıt olduğuna dair bildirim göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Başarıyla kayıt oldunuz!'),
          ),
        );
        // Giriş ekranına yönlendir
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamed(context, "/LoginScreen");
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        'Kayıt Ol',
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Madeinfinity",
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSignInLink(BuildContext context, String screen, String text) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, screen);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Madeinfinity",
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
