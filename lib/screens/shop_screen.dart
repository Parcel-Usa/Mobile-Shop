import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:parcel_usa/models/product.dart';
import 'details_screen.dart';


class ShopScreen extends StatefulWidget {

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  List<Product> products = [];

  int order_length = 0;
  List<int> orders_in_category = [];

  List<String> categories = [];
  Set<String> ct = {};

  int selectedIndex = 0;

  String category = '', name = '', description = '';
  int price = 0;
  List<String> images = [], features = [], features_values = [];

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
        products.add(Product(category: category, name: name, description: description, price: price, images: images, features: features, features_values: features_values));
        category = '';
        name = '';
        description = '';
        price = 0;
        images = [];
        features = [];
        features_values = [];
      } else {
        if (!flag_url) {
          list[i] = list[i].substring(1, list[i].length-2);
          String text = utf8.decode(base64.decode(list[i]));
          if (j % 2 == 0 && j >= 4) {
            features.add(text);
          } else if (j % 2 == 1 && j >= 4) {
            features_values.add(text);
          } else if (j == 0) {
            category = text;
            ct.add(text);
          } else if (j == 1) {
            name = text;
          } else if (j == 2) {
            description = text;
          }
          else if (j == 3) {
            price = int.parse(text);
          }
          j += 1;
        } else {
          list[i] = list[i].substring(0, list[i].length-1);
          images.add(list[i]);
        }
      }
    }
    categories = ct.toList();
    order_length = order;
    setState(() {
      for (int i = 0; i < order_length; i++) {
        if (categories[selectedIndex] == products[i].category) {
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
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(product: products[orders_in_category[index]]))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Image.network(products[orders_in_category[index]].images[0])
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              products[orders_in_category[index]].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₽ ' + products[orders_in_category[index]].price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: () {},
              ),
            ],
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
            if (categories[selectedIndex] == products[i].category) {
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