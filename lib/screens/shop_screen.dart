import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  List<String> categories = ['Кроссовки', 'Одежда', 'Очки'];
  List<AssetImage> categories_pictures = [AssetImage('assets/test_pic.png'), AssetImage('assets/test_pic2.png'), AssetImage('assets/test_pic1.png')];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text('Магазин', style: TextStyle(fontFamily: 'Merriweather', fontSize: 35)),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 25,
            child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => BuildCategory(index, context)
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => ItemCard(index),
            ),
          )
        ],
      ),
    );
  }

  Widget ItemCard(int index) {
    return Container();
  }

  Widget BuildCategory(int index, context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(categories[index], style: TextStyle(fontWeight: FontWeight.bold, color: selectedIndex == index ? Color(0xffa6bead) : Colors.grey, fontSize: 15),),
            Container(
              padding: EdgeInsets.only(top: 15),
              height: 2,
              width: 40,
              color: selectedIndex == index ? Color(0xffb95144) : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}