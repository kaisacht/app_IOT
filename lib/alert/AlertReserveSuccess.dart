import 'package:first_app/view/SeePackingLot.dart';
import 'package:flutter/material.dart';

import '../loginandsignup/Login.dart';

showAlertDialogReserveSuccess(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SeeParkingLotPage()));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Thông báo"),
    content: const Text("Đặt cỗ thành công"),
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

