import 'dart:io';
import 'package:first_app/main.dart';
import 'package:first_app/view/HomeUser.dart';
import 'package:first_app/view/SeePackingLot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_app/api/APILoginAndSignUp.dart';
import 'package:flutter/material.dart';

import '../alert/AlertLoginFail.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final APILoginAndSignUp apiLoginAndSignUp = APILoginAndSignUp();
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
          },
          icon: const Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text("Đăng nhập",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    Text("Đăng nhập với tài khoản của bạn",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Tên đăng nhập',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ],
                  ),
                ),
                Padding(padding:
                const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration:
                    BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async{
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const SeeParkingLotPage()));
                        String username = usernameController.text;
                        String password = passwordController.text;
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        String? token = await apiLoginAndSignUp.getCodeLogin(username, password);
                        if(token != null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                          saveCredentialsToFile(username, password, token);
                        }else{
                          showAlertDialogLoginFail(context);
                        }
                      },
                      color: const Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Đăng nhập", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Bạn chưa có tài khoản?"),
                    Text(" Đăng ký", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),)
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage("assets/background.png"),
                    //     fit: BoxFit.fitHeight
                    // ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
  void saveCredentialsToFile(String username, String password, String token) async {
    const String fileName = 'dataUser.txt';
    final String content = 'Username: $username\nPassword: $password\nToken: $token\n';

    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$fileName');
      await file.writeAsString(content);
    } catch (e) {
    }
  }
}
