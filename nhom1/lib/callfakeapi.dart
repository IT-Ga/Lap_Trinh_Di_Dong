
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageApp4(),
    );
  }
}
class HomePageApp4 extends StatefulWidget {
  const HomePageApp4({Key? key}) : super(key: key);

  @override
  _HomePageApp4State createState() => _HomePageApp4State();
}

class _HomePageApp4State extends State<HomePageApp4> {

  late Future<List<Photos>> lsPhotos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsPhotos = Photos.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: lsPhotos,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

              if (snapshot.hasData)
              {
                var data = snapshot.data as List<Photos>;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      Photos p = data[index];
                      return Card(
                          child: Column(
                            children: [
                              Image.network(p.thumbnailUrl),
                              Text(
                                p.title,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                      );
                    });
              }
              else
              {
                return CircularProgressIndicator();
              }
            }
        )
    );
  }
}
class Photos{

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos({required this.albumId, required this.id, required this.title, required this.url, required this.thumbnailUrl});

  static Future<List<Photos>> fetchData ()
  async {
    String url = "https://jsonplaceholder.typicode.com/photos";
    var client = http.Client();
    //lấy dữ liệu về
    var response = await client.get(Uri.parse(url));
    if(response.statusCode == 200)
    {
      var result = response.body;
      var jsonData = jsonDecode(result);//.cast<List<Map<String, dynamic>>>();
      // Xem kiểu dữ liệu lấy về là gì
      // print(result.runtimeType);
      // print(jsonData.runtimeType);
      // print(jsonData[0].runtimeType);
      // print(jsonData[0]);
      List<Photos> ls = [];
      for(var item in jsonData)
      {
        //print(item['title']);
        Photos p = new Photos(
            albumId: item['albumId'],
            id: item['id'],
            title: item['title'],
            url: item['url'],
            thumbnailUrl: item['thumbnailUrl']
        );
        ls.add(p);
      }
      return ls;
    }
    else
    {
      throw Exception("Lỗi lấy dữ liệu: ${response.statusCode}");
    }
  }
}