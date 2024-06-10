import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişim'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Image.asset(
                  'assets/images/logos/logoiki2.png',
                  height: 120.0,
                  width: 120.0,
                ),
              ),
            ),

            // İletişim Bilgileri
            _buildInfoCard(
              'İletişim Bilgileri',
              [
                'Adres: Odunİskelesi Sokak, YavuzSultanSelim Mahallesi, İstanbul',
                'Telefon: 555-555-5555',
                'E-posta: info@example.com',
              ],
            ),

            // İletişim Formu
            _buildContactForm(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 3),
    );
  }

  Widget _buildInfoCard(String title, List<String> infoList) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: infoList.map((info) => Text(info)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'İletişim Formu',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Adınız Soyadınız',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-posta Adresiniz',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Form gönderme işlemleri
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Form Gönderildi'),
                      content: Text('Mesajınız başarıyla gönderildi. Teşekkür ederiz!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tamam'),
                        ),
                      ],
                    );
                  },
                );

                // Formu temizle
                nameController.clear();
                emailController.clear();
              },
              child: Text('Mesaj Gönder'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomNavigationBarItem(
            context,
            Icons.home,
            "Ana Sayfa",
            "/home",
            currentIndex == 0,
          ),
          _buildBottomNavigationBarItem(
            context,
            Icons.person,
            "Profil",
            "/profile",
            currentIndex == 1,
          ),
          _buildBottomNavigationBarItem(
            context,
            Icons.shopping_basket,
            "Sepet",
            "/shopping_cart",
            currentIndex == 2,
          ),
          _buildBottomNavigationBarItem(
            context,
            Icons.contact_mail,
            "İletişim",
            "/contact",
            currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
    bool isSelected,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isSelected ? Colors.blue : Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }
}
