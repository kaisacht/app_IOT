import 'package:flutter/material.dart';

showAlertDialogRegisterFail400(BuildContext context) {
  // Set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red, // Màu sắc của biểu tượng cảnh báo
        ),
        SizedBox(width: 8), // Khoảng cách giữa biểu tượng và tiêu đề
        Text(
          "Thông báo",
          style: TextStyle(color: Colors.red), // Màu sắc của tiêu đề
        ),
      ],
    ),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tên đăng nhập đã tồn tại.",
          style: TextStyle(color: Colors.black87), // Màu sắc của nội dung
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
