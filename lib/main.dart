import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

enum TabItem { home, favorite, notification, account }

class MainPageState extends State<MainPage> {
  TabItem _currentItem = TabItem.home;
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.favorite,
    TabItem.notification,
    TabItem.account,
  ];

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];
    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _bottomTabs
                .map((tabItem) => _bottomNavigationBarItem(tabItem))
                .toList(),
            onTap: _onSelectTab,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildPage(),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(TabItem tabItem) {
    Color color = _currentItem == tabItem ? Colors.green : Colors.grey.shade400;

    IconData _icon(TabItem item) {
      switch (item) {
        case TabItem.home:
          return Icons.home_rounded;
        case TabItem.favorite:
          return Icons.favorite;
        case TabItem.notification:
          return Icons.notifications;
        case TabItem.account:
          return Icons.person;
        default:
          throw 'Unknown $item';
      }
    }

    return BottomNavigationBarItem(
      icon: Icon(
        _icon(tabItem),
        color: color,
        size: 30,
      ),
      label: '',
    );
  }

  Widget _buildPage() {
    switch (_currentItem) {
      case TabItem.home:
        return HomePage();
      case TabItem.account:
        return AccountPage();
      default:
        return HomePage(); // Placeholder for other pages
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> _product = [
    Product(
      image: '1.png',
      title: 'Succulent Plant',
      price: 29.99,
      desc: 'Beautiful succulent plant for home decoration.',
    ),
    Product(
      image: '5.png',
      title: 'Dragon Plant',
      price: 25.99,
      desc: 'Elegant dragon plant for indoor gardening.',
    ),
    Product(
      image: '6.png',
      title: 'Raevnea Plant',
      price: 22.99,
      desc: 'Low-maintenance Raevnea plant for homes.',
    ),
    Product(
      image: '2.png',
      title: 'Potted Plant',
      price: 24.99,
      desc: 'Perfectly potted plant for your living space.',
    ),
    Product(
      image: '4.png',
      title: 'Ipsum Plant',
      price: 30.99,
      desc: 'Ipsum plant adds greenery to your interior.',
    ),
    Product(
      image: '3.png',
      title: 'Lorem Plant',
      price: 19.99,
      desc: 'Affordable Lorem plant for small spaces.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome to',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.shopping_cart_rounded,
                size: 30,
              ),
            ],
          ),
          const Text(
            'Plant Shop',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Row(
              children: [_searchBox(), _sortButton()],
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: _product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          product: _product[index],
                        ),
                      ),
                    );
                  },
                  child: _productItem(
                    title: _product[index].title,
                    image: _product[index].image,
                    price: _product[index].price.toString(),
                    isFavorited: Random().nextBool(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _sortButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const RotatedBox(
        quarterTurns: 45,
        child: Icon(
          Icons.tune,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _productItem({
    required String title,
    required String image,
    required String price,
    required bool isFavorited,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/' + image,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isFavorited
                        ? Colors.pink.shade100
                        : Colors.grey.shade400,
                  ),
                  child: Icon(Icons.favorite,
                      color: isFavorited ? Colors.pink : Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade400,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                  const Icon(Icons.favorite_outline),
                ],
              ),
            ),
            Image.asset(
              'assets/images/${product.image}',
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                product.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.green,
              child: const Text(
                'Add to Cart',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String image;
  final String title;
  final double price;
  final String desc;

  Product(
      {required this.image,
        required this.title,
        required this.price,
        required this.desc});
}
