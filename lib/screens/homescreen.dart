import 'package:flutter/material.dart';

class FoodItem {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  int rating;
  List<String> ingredients;

  FoodItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 0,
    this.ingredients = const [],
  });
}

class HomeScreen extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem(
      title: 'Pizza',
      description: 'Mozzarella peyniri ve sebzelerle yapılmış lezzetli pizza.',
      price: '\₺100',
      imageUrl: 'assets/images/foods/pizza.jpeg',
      rating: 4,
    ),
    FoodItem(
      title: 'Hamburger',
      description: 'Büyük boy dana etli hamburger.',
      price: '\₺80',
      imageUrl: 'assets/images/foods/hamburger.jpeg',
      rating: 3,
    ),
    FoodItem(
      title: 'Lahmacun',
      description: 'Kömür ateşinde leziz bir Lahmacun.',
      price: '\₺50',
      imageUrl: 'assets/images/foods/lahmacun.jpeg',
      rating: 5,
    ),
    FoodItem(
      title: 'Mercimek Çorbası',
      description: 'Vazgeçilmez Çorbalardan Mercimek Çorbası.',
      price: '\₺35',
      imageUrl: 'assets/images/foods/mercimekçorbası.jpeg',
      rating: 4,
    ),
    FoodItem(
      title: 'Pilav Tavuk',
      description: 'Terayağlı pilav yanına tiftik tavuk.',
      price: '\₺70',
      imageUrl: 'assets/images/foods/pilavtavuk.jpeg',
      rating: 3,
    ),
    FoodItem(
      title: 'Döner',
      description: 'Dana etinden meşhur Et döner.',
      price: '\₺75',
      imageUrl: 'assets/images/foods/döner.jpeg',
      rating: 5,
    ),
    FoodItem(
      title: 'Izgara Tavuk',
      description: 'Izgara tavuk butları.',
      price: '\₺60',
      imageUrl: 'assets/images/foods/ızgaratavuk.jpeg',
      rating: 4,
    ),
    FoodItem(
      title: 'Makarna',
      description: 'Bol peynirli ve soslu makarna.',
      price: '\₺45',
      imageUrl: 'assets/images/foods/makarna.jpeg',
      rating: 4,
    ),
    FoodItem(
      title: 'Salata',
      description: 'Çeşitli malzemelerle hazırlanmış salata.',
      price: '\₺30',
      imageUrl: 'assets/images/foods/salata.jpeg',
      rating: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 174, 175, 175),
        title: Text(
          'Lezzet Durağı',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: FoodSearch());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100),
                    child: Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logos/logoiki2.png',
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Yemekler',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            foodItem: foodItems[index],
                          ),
                        ),
                      );
                    },
                    child: buildFoodItem(
                      context,
                      foodItems[index].title,
                      foodItems[index].description,
                      foodItems[index].price,
                      foodItems[index].imageUrl,
                      Colors.white,
                      Colors.black,
                      foodItems[index].rating,
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.transparent, // Şeffaf arka plan rengi
                          foregroundColor: Colors.black),
                      child: Column(
                        children: [
                          Icon(Icons.home),
                          Text("Ana Sayfa"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.transparent, // Şeffaf arka plan rengi
                          foregroundColor: Colors.black),
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Text("Profil"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/shopping_cart');
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.transparent, // Şeffaf arka plan rengi
                          foregroundColor: Colors.black),
                      child: Column(
                        children: [
                          Icon(Icons.shopping_basket),
                          Text("Sepet"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.transparent, // Şeffaf arka plan rengi
                          foregroundColor: Colors.black),
                      child: Column(
                        children: [
                          Icon(Icons.contact_mail),
                          Text("İletişim"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFoodItem(
      BuildContext context,
      String title,
      String description,
      String price,
      String imageUrl,
      Color backgroundColor,
      Color textColor,
      int rating) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sepete Eklendi'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    minimumSize: Size(100, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sepete Ekle',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final FoodItem foodItem;

  const DetailPage({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                foodItem.imageUrl,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Açıklama:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              foodItem.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Malzemeler:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foodItem.ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(foodItem.ingredients[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Değerlendirme:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Değerlendirme yıldızları ve yorumlar için alanlar buraya eklenecek
          ],
        ),
      ),
    );
  }
}

class FoodSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Arama Sonuçları: $query'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Öneriler: $query'),
      ),
    );
  }
}
