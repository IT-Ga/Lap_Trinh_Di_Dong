import 'package:flutter/material.dart';
import 'package:nhom1/news_screen.dart';
import 'package:nhom1/article_services.dart';
import 'package:nhom1/api_key.dart';
import 'package:nhom1/article.dart';
import 'package:nhom1/article_api.dart';
import 'package:nhom1/article_item.dart';
import 'package:nhom1/news_screen.dart';
import 'package:nhom1/webview_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFFf2f2f2),
        primaryColor: Color(0xFF00A6E4),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF0E2656),
        ),
      ),
      home: NewScreen(articleApi: ArticleServices()),
    );
  }
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget createColumn(String data, IconData icons){
    Color color = Colors.red;
    double size = 30;
    return Column(
      children: [
        Icon(
          icons,
          textDirection: TextDirection.ltr,
          color: color,
          size: size,
        ),
        Text(data,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: color,
              fontSize: size
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.ltr,
            children: [
              createColumn("Call", Icons.call),
              createColumn("Route", Icons.router),
              createColumn("Share", Icons.share)

            ],
          )
      ),
      decoration: BoxDecoration(
          color: Colors.white
      ),
      padding: EdgeInsets.all(50),
    );
  }
}
*/
