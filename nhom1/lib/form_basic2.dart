import 'package:flutter/material.dart';
class MyAppss extends StatelessWidget {
  const MyAppss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:FormBasic(),
    );
  }
}


class FormBasic extends StatefulWidget {
  const FormBasic({Key? key}) : super(key: key);

  @override
  _FormBasicState createState() => _FormBasicState();
}

class _FormBasicState extends State<FormBasic> {
  var fkey=GlobalKey<FormState>();
  var txtTenDangNhap= TextEditingController();
  var txtMatKhau= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập hệ thống"),
      ),
      body: Form(
        key: fkey,
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("Đăng nhập hệ thống",style: TextStyle(fontSize: 35,color: Colors.orange),),
            TextFormField(
              controller: txtTenDangNhap,
              validator: (value){
                if(value==null||value.isEmpty)
                  return "Vui lòng nhập tên đăng nhập";
                else
                  return null;
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "Nhập tên đăng nhập",
                  labelText: "Tên đăng nhập (*)"
              ),

            ),
            TextFormField(
              controller: txtMatKhau,
              validator: (value){
                if(value==null||value.isEmpty)
                  return "Vui lòng nhập mật khẩu";
                else if (value.length<6)
                  return "Mật khẩu phải có độ dài ít nhất 6 ký tự ";
                else
                  return null;
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_open),
                  hintText: "Nhập mật khẩu",
                  labelText: "Mật khẩu (*)"
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  if (fkey.currentState!.validate()){
                    var tenDangNhap=txtTenDangNhap.text;
                    var matKhau=txtMatKhau.text;
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        content: Text("Tên đăng nhập: ${tenDangNhap},Mật khẩu: ${matKhau}"),
                      );
                    });
                    print("Ok,${tenDangNhap},${matKhau}");
                  }
                  else
                    print("Not passs");
                },
                child: Text("Đăng nhập")),
          ],
        ),
      ),
    );
  }
}
