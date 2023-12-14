import 'package:flutter/material.dart';

showAlertDialogLoginFail(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red), // Icon trước tiêu đề
        SizedBox(width: 8), // Khoảng cách giữa icon và text
        Text(
          "Thất bại",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(64, 64, 64, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    ),
    titlePadding: const EdgeInsets.only(top: 24),
    content: const Text(
      "Tài khoản hoặc mật khẩu không đúng",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(64, 64, 64, 1.0)),
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
