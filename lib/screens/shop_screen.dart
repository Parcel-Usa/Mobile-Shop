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
          Container(
            decoration: BoxDecoration(
              color: Color(0xffe6e8d2).withOpacity(0.5),
            ),
            height: 350,
            child: ListWheelScrollView(
              itemExtent: 200,
              offAxisFraction: -1.5,
              diameterRatio: 6,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) => {
                print(index)
              },
              children: List.generate(categories.length, (index) =>
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(20),
                        width: 350,
                        child: Column(
                          children: [
                            Text(categories[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(1, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 220,
                        child: Image(image: categories_pictures[index],),
                      )
                    ],
                  ))
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                  ),
                hintText: 'Поиск',
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Color(0xffb95144)
              ),
            ),
          )
        ],
      )
    );
  }
}