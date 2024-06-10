import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  final List<CartItem> cartItems = [
    CartItem('Pizza', 100, 'assets/images/foods/pizza.jpeg'),
    CartItem('Hamburger', 80, 'assets/images/foods/hamburger.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    cartItems[index].imageUrl,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(cartItems[index].name),
                  subtitle: Text('${cartItems[index].price} ₺'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Siparişiniz alınmıştır')),
                );
              },
              child: Text('Siparişi Tamamla'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 2),
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

class CartItem {
  final String name;
  final int price;
  final String imageUrl;

  CartItem(this.name, this.price, this.imageUrl);
}
