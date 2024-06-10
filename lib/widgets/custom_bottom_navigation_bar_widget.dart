import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 56.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(Icons.home, 'Ana Sayfa', 0, context),
          _buildNavBarItem(Icons.person, 'Profil', 1, context),
          _buildNavBarItem(Icons.shopping_cart, 'Sepetim', 2, context),
          _buildNavBarItem(Icons.email, 'İletişim', 3, context),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/profile');
            break;
          case 2:
            Navigator.pushNamed(context, '/shopping_cart');
            break;
          case 3:
            Navigator.pushNamed(context, '/contact');
            break;
          default:
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentIndex == index ? Colors.blue : Colors.grey,
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
