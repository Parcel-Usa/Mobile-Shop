import 'package:flutter/material.dart';
import 'package:parcel_usa/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffa6bead),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: product.images.length,
              itemBuilder: (BuildContext context, int itemIndex, int PageViewIndex) =>
                  Image.network(product.images[itemIndex]),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 10),
                autoPlayAnimationDuration: Duration(milliseconds: 1500),
                viewportFraction: 0.6,
                reverse: false,
                enableInfiniteScroll: false
              ),
            )
          ],
        ),
      ),
    );
  }
}