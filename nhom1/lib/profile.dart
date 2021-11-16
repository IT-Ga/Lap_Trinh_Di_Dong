import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class MyApp7 extends StatelessWidget {
  const MyApp7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color text_color = Color.fromRGBO(52, 73, 94, 1.0);
  Color default_color = Color(0xff8395a7);
  Color bar_color = Color(0xffdcdde1);
  Color bar_color_sl = Color(0xff0097e6);

  late Future<Myprofile> myProfile;

  var id = TextEditingController();
  var titlename = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var gender = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var country = TextEditingController();
  var timezone = TextEditingController();
  var email = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var date = TextEditingController();
  var age = TextEditingController();
  var phone = TextEditingController();
  var cell = TextEditingController();

  @override
  void initState() {
    super.initState();
    myProfile = Myprofile.fetchData();
  }

  Widget my_input(
      {String? hintText,
        String? labelText,
        String? Function(String?)? validator,
        TextEditingController? controller,
        String obscuringCharacter = "*",
        bool obscureText = false}) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
      ),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                hintText ?? "",
                style: TextStyle(
                  color: default_color,
                ),
              )),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              // labelText: labelText,
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorStyle: TextStyle(color: Colors.white),
              hoverColor: Colors.white,
              labelStyle: TextStyle(
                color: text_color,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(color: text_color, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () {},
            child: Text(
              "Save",
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: myProfile,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as Myprofile;
              id.text = data.results[0].id.name + "-" + data.results[0].id.value;
              titlename.text = data.results[0].name.title;
              firstname.text = data.results[0].name.first;
              lastname.text = data.results[0].name.last;
              gender.text = data.results[0].gender;
              street.text = data.results[0].location.street.number.toString() + data.results[0].location.street.name;
              city.text = data.results[0].location.city;
              state.text = data.results[0].location.state;
              country.text = data.results[0].location.country;
              timezone.text = data.results[0].location.timezone.offset + " " + data.results[0].location.timezone.description;
              email.text = data.results[0].email;
              date.text = data.results[0].dob.date.toString();
              age.text = data.results[0].dob.age.toString();
              username.text = data.results[0].login.username;
              password.text = data.results[0].login.password;
              phone.text = data.results[0].phone;
              cell.text = data.results[0].cell;
              return Container(
                color: Color(0xfff5f6fa),
                child: ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.all(30),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(data.results[0].picture.medium)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          my_input(hintText: "Id", controller: id),
                          my_input(hintText: "Title Name", controller: titlename),
                          my_input(hintText: "First Name", controller: firstname),
                          my_input(hintText: "Last Name", controller: lastname),
                          my_input(hintText: "Gender", controller: gender),
                          my_input(hintText: "Street", controller: street),
                          my_input(hintText: "City", controller: city),
                          my_input(hintText: "State", controller: state),
                          my_input(hintText: "Country", controller: country),
                          my_input(hintText: "Timezone", controller: timezone),
                          my_input(hintText: "Email", controller: email),
                          my_input(hintText: "Date", controller: date),
                          my_input(hintText: "Age", controller: age),
                          my_input(hintText: "UserName", controller: username),
                          my_input(hintText: "Password", obscureText: true, controller: password),
                          my_input(hintText: "Phone", controller: phone),
                          my_input(hintText: "Cell", controller: cell),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: Colors.lightBlue,)
              );
            }
          }
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 20,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.credit_card,
                  size: 30,
                  color: bar_color,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.receipt,
                  size: 30,
                  color: bar_color,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: bar_color_sl,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                  color: bar_color,
                ),
              ),
            ],
          ),
        ),
        color: Colors.white,
        elevation: 0,
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final myprofile = myprofileFromJson(jsonString);

Myprofile myprofileFromJson(String str) => Myprofile.fromJson(json.decode(str));

String myprofileToJson(Myprofile data) => json.encode(data.toJson());

class Myprofile {
  Myprofile({
    required this.results,
    required this.info,
  });

  List<Result> results;
  Info info;

  static Future<Myprofile> fetchData() async {
    print("fetching");
    String url = "https://randomuser.me/api/";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = response.body;
      var jsonData = jsonDecode(result);
      print(jsonData);
      return Myprofile.fromJson(jsonData);
    } else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${response.statusCode}");
    }
  }

  factory Myprofile.fromJson(Map<String, dynamic> json) => Myprofile(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}

class Info {
  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  String seed;
  int results;
  int page;
  String version;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    seed: json["seed"],
    results: json["results"],
    page: json["page"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "seed": seed,
    "results": results,
    "page": page,
    "version": version,
  };
}

class Result {
  Result({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob dob;
  Dob registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    gender: json["gender"],
    name: Name.fromJson(json["name"]),
    location: Location.fromJson(json["location"]),
    email: json["email"],
    login: Login.fromJson(json["login"]),
    dob: Dob.fromJson(json["dob"]),
    registered: Dob.fromJson(json["registered"]),
    phone: json["phone"],
    cell: json["cell"],
    id: Id.fromJson(json["id"]),
    picture: Picture.fromJson(json["picture"]),
    nat: json["nat"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "name": name.toJson(),
    "location": location.toJson(),
    "email": email,
    "login": login.toJson(),
    "dob": dob.toJson(),
    "registered": registered.toJson(),
    "phone": phone,
    "cell": cell,
    "id": id.toJson(),
    "picture": picture.toJson(),
    "nat": nat,
  };
}

class Dob {
  Dob({
    required this.date,
    required this.age,
  });

  DateTime date;
  int age;

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
    date: DateTime.parse(json["date"]),
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "age": age,
  };
}

class Id {
  Id({
    required this.name,
    required this.value,
  });

  String name;
  String value;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  Street street;
  String city;
  String state;
  String country;
  int postcode;
  Coordinates coordinates;
  Timezone timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: Street.fromJson(json["street"]),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    timezone: Timezone.fromJson(json["timezone"]),
  );

  Map<String, dynamic> toJson() => {
    "street": street.toJson(),
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "coordinates": coordinates.toJson(),
    "timezone": timezone.toJson(),
  };
}

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  String latitude;
  String longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Street {
  Street({
    required this.number,
    required this.name,
  });

  int number;
  String name;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
    number: json["number"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
  };
}

class Timezone {
  Timezone({
    required this.offset,
    required this.description,
  });

  String offset;
  String description;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    offset: json["offset"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "description": description,
  };
}

class Login {
  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    uuid: json["uuid"],
    username: json["username"],
    password: json["password"],
    salt: json["salt"],
    md5: json["md5"],
    sha1: json["sha1"],
    sha256: json["sha256"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "username": username,
    "password": password,
    "salt": salt,
    "md5": md5,
    "sha1": sha1,
    "sha256": sha256,
  };
}

class Name {
  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  String title;
  String first;
  String last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    title: json["title"],
    first: json["first"],
    last: json["last"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "first": first,
    "last": last,
  };
}

class Picture {
  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  String large;
  String medium;
  String thumbnail;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    large: json["large"],
    medium: json["medium"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "large": large,
    "medium": medium,
    "thumbnail": thumbnail,
  };
}