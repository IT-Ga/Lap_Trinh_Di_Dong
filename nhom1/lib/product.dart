import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class MyApp6 extends StatelessWidget {
  const MyApp6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Product(),
    );
  }
}

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late Future<List<cProduct>> lsProduct;
  late Future<List<PanelImage>> lsPanelImage;

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    lsProduct = cProduct.fetchData();
    lsPanelImage = PanelImage.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "SẢN PHẨM",
            style: TextStyle(
                color: Color.fromRGBO(44, 62, 80, 1.0),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
        ),
        body: FutureBuilder(
          future: Future.wait([lsPanelImage, lsProduct]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data1 = snapshot.data![0] as List<PanelImage>;
              var data2 = snapshot.data![1] as List<cProduct>;
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              spreadRadius: 0.1,
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: [
                        CarouselSlider(
                          items: data1.map((p){
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(
                                  p.url,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16/9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          carouselController: buttonCarouselController,
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(44, 62, 80, 1.0),
                                    shape: StadiumBorder(),
                                  ),
                                  onPressed: () => buttonCarouselController.previousPage(
                                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                                  child: Icon(Icons.arrow_left),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(44, 62, 80, 1.0),
                                    shape: StadiumBorder(),
                                  ),
                                  onPressed: () => buttonCarouselController.nextPage(
                                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                                  child: Icon(Icons.arrow_right),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GridView.builder(
                    itemCount: data2.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      cProduct p = data2[index];
                      return Center(
                        child: Container(
                          height: 1000,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  p.image,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.title,
                                      softWrap: false,
                                    ),
                                    Text(
                                      p.price.toString() + "\$",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "+ GIỎ HÀNG",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0.1,
                                    blurRadius: 10)
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 7/10,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                  )
                ],
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: Colors.amber,)
              );
            }
          },
        )
    );
  }
}

class cProduct {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  cProduct(
      {required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rate,
        required this.count});

  static Future<List<cProduct>> fetchData() async {
    print("fetching");
    String url = "https://fakestoreapi.com/products?limit=100";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<cProduct> ls = [];
      for (var item in jsonData) {
        cProduct p = new cProduct(
            id: item["id"],
            title: item["title"],
            price: item["price"],
            description: item["description"],
            category: item["category"],
            image: item["image"],
            rate: item["rating"]["rate"],
            count: item["rating"]["count"]);
        ls.add(p);
      }
      return ls;
    } else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${response.statusCode}");
    }
  }
}

class PanelImage {
  final int id;
  final String url;

  PanelImage({required this.id, required this.url});

  static Future<List<PanelImage>> fetchData() async {
    print("fetching");
    String url = "https://fakestoreapi.com/products?limit=10";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<PanelImage> ls = [];
      for (var item in jsonData) {
        PanelImage p = new PanelImage(
            id: item["id"],
            url: item["image"]
        );
        ls.add(p);
      }
      return ls;
    } else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${response.statusCode}");
    }
  }
}