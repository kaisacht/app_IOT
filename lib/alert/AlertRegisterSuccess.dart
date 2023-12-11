import 'package:flutter/material.dart';

import '../loginandsignup/Login.dart';

showAlertDialogRegisterSuccess(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Thông báo"),
    content: const Text("Đăng ký thành công"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

