import 'package:flutter/material.dart';
import 'package:parcel_usa/screens/basket_screen.dart';
import 'package:parcel_usa/screens/info_screen.dart';
import 'package:parcel_usa/screens/news_screen.dart';
import 'package:parcel_usa/screens/shop_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List pages = [
    NewsScreen(),
    ShopScreen(),
    BasketScreen(),
    InfoScreen()
  ];


  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: Offset(2, 2)
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffb95144),
            unselectedItemColor: Color(0xffa6bead).withOpacity(0.9),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'Новости'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility_sharp),
                  label: 'Магазин'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_rounded),
                  label: 'Корзина'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'О нас'
              ),
            ],
          ),
        ),
      )
    );
  }
}