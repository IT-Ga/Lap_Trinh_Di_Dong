import 'package:flutter/material.dart';

import 'package:nhom1/form_basic.dart';

class FormRegister extends StatelessWidget{
  const FormRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FRegister(),
    );
  }
}

class FRegister extends StatefulWidget {
  const FRegister({Key? key}) : super(key: key);

  @override
  _FRegisterState createState() => _FRegisterState();
}

class _FRegisterState extends State<FRegister> {
  var fkey = GlobalKey<FormState>();
  var txtName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtUserName = TextEditingController();
  var txtPassword = TextEditingController();

  Paint paint = Paint();

  _FRegisterState() {
    paint.color = Colors.white;
    paint.strokeWidth = 15;
    paint.style = PaintingStyle.stroke;
  }
  Widget myTextField({Icon? icon, String? hintText, String? labelText, String? Function(String?)? validator, TextEditingController? controller, String obscuringCharacter = "*", bool obscureText = false}) {
    return
      Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(
            left: 10,
            top: 5,
            bottom: 5,
            right: 5
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
            ),
            icon: icon,
            errorStyle: TextStyle(
                color: Colors.white
            ),
            hoverColor: Colors.white,
            labelStyle: TextStyle(
                color: Colors.amber,
                background: paint
            ),

          ),
          validator: validator,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
        ),
        decoration: BoxDecoration(
            color: Colors.amber,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                spreadRadius: 0.1,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 70, left: 50),
                alignment: Alignment.topLeft,
                child: Text(
                  "ĐĂNG NHẬP",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 800,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(200),
                        topLeft: Radius.circular(200)
                    ),
                    boxShadow:
                    [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 20
                      )
                    ]
                ),
                child: Form(
                  key: fkey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 100,
                        right: 70,
                        left: 70
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        myTextField(
                          controller: txtName,
                          icon: Icon(Icons.person),
                          hintText: "Họ và tên",
                          labelText: "Họ và tên*",
                          validator: (value){
                            if (value == null || value.isEmpty)
                              return "Vui lòng nhập họ và tên";
                            else
                              return null;
                          },
                        ),
                        myTextField(
                          controller: txtEmail,
                          icon: Icon(Icons.person),
                          hintText: "Email",
                          labelText: "Email*",
                          validator: (value){
                            if (value == null || value.isEmpty)
                              return "Vui lòng nhập Email";
                            else
                              return null;
                          },
                        ),
                        myTextField(
                          controller: txtUserName,
                          icon: Icon(Icons.person),
                          hintText: "Tên đăng nhập",
                          labelText: "Tên đăng nhập*",
                          validator: (value){
                            if (value == null || value.isEmpty)
                              return "Vui lòng nhập tên đăng nhập";
                            else
                              return null;
                          },
                        ),
                        myTextField(
                            controller: txtPassword,
                            validator: (value){
                              if (value == null || value.isEmpty)
                                return "Vui lòng nhập mật khẩu";
                              else if (value.length < 6)
                                return "Nhập lại mật khẩu";
                              else
                                return null;
                            },
                            icon: Icon(Icons.lock_open),
                            hintText: "Mật khẩu",
                            labelText: "Mật khẩu*",
                            obscureText: true
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 30
                          ),
                          width: 200,
                          child: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold
                            ),
                              padding: EdgeInsets.all(20),
                              primary: Colors.amber,
                            ),
                            onPressed: (){
                              if (fkey.currentState!.validate()){
                                var userName = txtUserName.text;
                                var password = txtPassword.text;
                                var name = txtName.text;
                                var email = txtEmail.text;
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    content: Text("Họ và tên: ${name} \nEmail: ${email} \nTên đăng nhập: ${userName} \n"
                                        "Mật khẩu: ${password}"),
                                  );
                                });
                                print("Ok, all pass ${userName} - ${password}");
                              } else {
                                print("Not pass");
                              }
                            },
                            child: Text("ĐĂNG KÝ"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 200,
                          child: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold
                            ),
                              padding: EdgeInsets.all(20),
                              primary: Colors.pink,
                            ),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => FormBasic())
                              );
                            },
                            child: Text("ĐĂNG NHẬP"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}