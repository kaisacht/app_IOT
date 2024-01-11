

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/SeePackingLot.dart';

showAlertDialogReserveFail(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SeeParkingLotPage(),
        ),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Thông báo"),
    content: const Text("Có lỗi xảy ra, đặt cỗ thất bại"),
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
