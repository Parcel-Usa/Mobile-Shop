import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ShopScreen extends StatefulWidget {

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  List<String> orders_description = [];
  List<String> orders_name = [];
  List<String> orders_price = [];
  List<String> orders_categories = [];
  List<List<String>> orders_feautes = [];
  List<List<String>> orders_feautes_values = [];
  List<List<String>> orderes_pictures = [];
  int order_length = 0;
  List<int> orders_in_category = [];

  List<String> categories = [];
  List<AssetImage> categories_pictures = [AssetImage('assets/test_pic.png'), AssetImage('assets/test_pic2.png'), AssetImage('assets/test_pic1.png')];

  int selectedIndex = 0;

  final dio = Dio();

  @override
  void initState() {
    super.initState();
    get_data();
  }

  void get_data() async {
    final response = await dio.get("http://10.100.20.21/get_order_info");
    List<String> list = response.data.toString().split('\n');
    bool flag_url = false;
    int j = 0;
    int order = 0;
    for (int i = 0; i < list.length - 1; i += 1) {
      if (list[i] == '&') {
        flag_url = true;
      } else if (list[i] == '|') {
        j = 0;
        order += 1;
        flag_url = false;
      } else {
        if (!flag_url) {
          list[i] = list[i].substring(1, list[i].length-2);
          String text = utf8.decode(base64.decode(list[i]));
          if (j % 2 == 0 && j >= 4) {
            orders_feautes.add([]);
            orders_feautes[order].add(text);
          } else if (j % 2 == 1 && j >= 4) {
            orders_feautes_values.add([]);
            orders_feautes_values[order].add(text);
          } else if (j == 0) {
            orders_categories.add(text);
          } else if (j == 1) {
            orders_name.add(text);
          } else if (j == 2) {
            orders_description.add(text);
          }
          else if (j == 3) {
            orders_price.add(text);
          }
          j += 1;
        } else {
          list[i] = list[i].substring(0, list[i].length-1);
          orderes_pictures.add([]);
          orderes_pictures[order].add(list[i]);
        }
      }
    }
    order_length = order;
    setState(() {
      categories = (orders_categories.toSet()).toList();
      for (int i = 0; i < order_length; i++) {
        if (categories[selectedIndex] == orders_categories[i]) {
          orders_in_category.add(i);
        }
      }
    });
  }

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: GridView.builder(
                itemCount: orders_in_category.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) => ItemCard(index),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget ItemCard(int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Hero(
                tag: '₽' + orders_name[orders_in_category[index]],
                child: Image.network(orderes_pictures[orders_in_category[index]][0]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              orders_name[orders_in_category[index]],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            orders_price[orders_in_category[index]],
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget BuildCategory(int index, context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          orders_in_category.clear();
          for (int i = 0; i < order_length; i++) {
            if (categories[selectedIndex] == orders_categories[i]) {
              orders_in_category.add(i);
            }
          }
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