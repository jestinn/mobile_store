import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: false,
                viewportFraction: 1,
              ),
              itemCount: (product.images!.length),
              itemBuilder: (context, index, realIdx) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                      Image.network(product.images![index], fit: BoxFit.cover),
                );
              },
            ),
            Divider(
              thickness: 3,
              color: Colors.grey,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    product.title ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(product.description ?? "",
                      overflow: TextOverflow.clip, style: TextStyle()),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('Buy ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
                Text(product.discountPercentage.toString()),
                Text("% off,   ₤",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(product.price.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text('Best Rating'),
                SizedBox(
                  width: 10,
                ),
                Text(product.rating.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(' out of 5'),
              ],
            ),
            Row(
              children: [
                Text('Book Now only '),
                Text(product.stock.toString()),
                Text(' left,  from '),
                Text(product.brand ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
