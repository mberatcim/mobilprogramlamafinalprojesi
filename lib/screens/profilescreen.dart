import 'dart:io';
import 'package:finalprojesi2/blocs/language_bloc.dart';
import 'package:finalprojesi2/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Ad Soyad';
  String phoneNumber = '555-555-5555';
  String emailAddress = 'example@email.com';
  String paymentMethod = 'Kredi Kartı';
  File? _image;

  List<OrderItem> orderHistory = [
    OrderItem('Pizza', '₺120', 'assets/images/foods/pizza.jpeg', DateTime(2022, 4, 20)),
    OrderItem('Hamburger', '₺80', 'assets/images/foods/hamburger.jpeg', DateTime(2022, 4, 18)),
  ];

  bool notificationsEnabled = true;
  bool isCardPayment = false;
  List<String> savedCards = ['**** **** **** 1234', '**** **** **** 5678'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, 'profile_image.png');
      await _image!.copy(imagePath);
    }
  }

  Future<void> _loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = path.join(directory.path, 'profile_image.png');

    if (File(imagePath).existsSync()) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              context.read<LanguageBloc>().add(LanguageEvent.toggle);
            },
          ),
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeEvent.toggle);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              ).then((result) {
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    name = result['name'] ?? name;
                    phoneNumber = result['phoneNumber'] ?? phoneNumber;
                    emailAddress = result['emailAddress'] ?? emailAddress;
                    paymentMethod = result['paymentMethod'] ?? paymentMethod;
                    isCardPayment = result['isCardPayment'] ?? isCardPayment;
                  });
                }
              });
            },
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                if (!notificationsEnabled)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              setState(() {
                notificationsEnabled = !notificationsEnabled;
              });
              if (!notificationsEnabled) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Bildirimler Kapalı'),
                      content: Text('Bildirimler şu anda kapalı.'),
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
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Çıkış Yap'),
                    content: Text('Çıkış yapmak istediğinize emin misiniz?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('İptal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Evet'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color.fromARGB(255, 250, 117, 117),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null ? Icon(Icons.camera_alt, size: 50.0) : null,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Telefon Numarası: $phoneNumber',
                    style: TextStyle(
                        fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email Adresi: $emailAddress',
                    style: TextStyle(
                        fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentMethods(context);
                    },
                    child: Text('Ödeme Yöntemleri'),
                  ),
                  if (isCardPayment) ...[
                    SizedBox(height: 16.0),
                    Text(
                      'Kayıtlı Kartlar',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: savedCards.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(savedCards[index]),
                          trailing: Icon(Icons.credit_card),
                        );
                      },
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _showAddCardDialog(context);
                      },
                      child: Text('Kart Ekle'),
                    ),
                  ],
                ],
              ),
            ),
            Container(child: buildOrderHistory(context)),
            SizedBox(height: 180),
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
                          elevation: 0,
                          backgroundColor: Colors.transparent,
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
                          elevation: 0,
                          backgroundColor: Colors.transparent,
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
                          elevation: 0,
                          backgroundColor: Colors.transparent,
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
                          elevation: 0,
                          backgroundColor: Colors.transparent,
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
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Fotoğraf Yükle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderHistory(BuildContext context) {
    orderHistory.sort((a, b) => b.orderDate.compareTo(a.orderDate));

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Geçmiş Siparişler',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: 8.0),
          Column(
            children: orderHistory.map((item) => buildOrderItem(context, item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildOrderItem(BuildContext context, OrderItem orderItem) {
    return GestureDetector(
      onTap: () {
        _showOrderDetails(context, orderItem);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.foodName,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Fiyat: ${orderItem.price}',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Tarih: ${orderItem.orderDate.day}/${orderItem.orderDate.month}/${orderItem.orderDate.year}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                orderItem.imageUrl,
                width: 60.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, OrderItem orderItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sipariş Detayları'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ürün Adı: ${orderItem.foodName}'),
              Text('Fiyat: ${orderItem.price}'),
              Text(
                  'Tarih: ${orderItem.orderDate.day}/${orderItem.orderDate.month}/${orderItem.orderDate.year}'),
              SizedBox(height: 8.0),
              Image.asset(
                orderItem.imageUrl,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ödeme Yöntemleri'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Kredi Kartı'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    paymentMethod = 'Kredi Kartı';
                    isCardPayment = true;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('Nakit'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    paymentMethod = 'Nakit';
                    isCardPayment = false;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  void _showAddCardDialog(BuildContext context) {
    TextEditingController cardNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kart Ekle'),
          content: TextField(
            controller: cardNumberController,
            decoration: InputDecoration(labelText: 'Kart Numarası'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  savedCards.add(cardNumberController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  String _selectedPaymentMethod = 'Kredi Kartı';
  bool _isCardPayment = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Ad Soyad';
    _phoneNumberController.text = '555-555-5555';
    _emailAddressController.text = 'example@email.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profili Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Ad Soyad'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Telefon Numarası'),
            ),
            TextField(
              controller: _emailAddressController,
              decoration: InputDecoration(labelText: 'Email Adresi'),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                  _isCardPayment = _selectedPaymentMethod == 'Kredi Kartı';
                });
              },
              items: <String>['Kredi Kartı', 'Nakit']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'name': _nameController.text,
                  'phoneNumber': _phoneNumberController.text,
                  'emailAddress': _emailAddressController.text,
                  'paymentMethod': _selectedPaymentMethod,
                  'isCardPayment': _isCardPayment,
                });
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem {
  final String foodName;
  final String price;
  final String imageUrl;
  final DateTime orderDate;

  OrderItem(this.foodName, this.price, this.imageUrl, this.orderDate);
}
