import 'package:flutter/material.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<Map<String, String>> boardingData = [
    {
      'title': 'Hoş Geldiniz',
      'subtitle': 'Uygulamamıza hoş geldiniz. Size harika özellikler sunacağız.',
      'image': 'assets/images/boarding1.png',
    },
    {
      'title': 'Kolay Kullanım',
      'subtitle': 'Uygulamamızın kullanımı çok kolay ve kullanıcı dostudur.',
      'image': 'assets/images/boarding2.png',
    },
    {
      'title': 'Başlayın',
      'subtitle': 'Hadi başlayalım! Hesabınızı oluşturarak devam edin.',
      'image': 'assets/images/boarding3.png',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _next() {
    if (_currentIndex == boardingData.length - 1) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: boardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(boardingData[index]['image']!),
                    SizedBox(height: 20),
                    Text(
                      boardingData[index]['title']!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      boardingData[index]['subtitle']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skip,
                  child: Text('Geç'),
                ),
                Row(
                  children: List.generate(
                    boardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _next,
                  child: Text(_currentIndex == boardingData.length - 1
                      ? 'Başla'
                      : 'İleri'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
