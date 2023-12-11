import 'dart:convert';

import 'package:first_app/api/APIGetAllVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:flutter/material.dart';

class GetAllVehiclesPage extends StatefulWidget {
  @override

  _GetAllVehiclesPage createState() =>
      _GetAllVehiclesPage();
}

class _GetAllVehiclesPage extends State<GetAllVehiclesPage> {
  final ReadFile readFile = ReadFile();
  final APIGetAllVehicles apiGetAllVehicles = APIGetAllVehicles();
  List<dynamic> items = []; // Danh sách các mục từ file JSON

  @override
  void initState() {
    super.initState();
    loadItemsFromJson();
  }

  Future<void> loadItemsFromJson() async {
    try {
      String? content = await readFile.readDataFromFile();
      if(content !=null) {
        List<String> lines = content.split('\n');
        int startIndex = content.indexOf('Token: ') + 'Token: '.length;
        String token = content.substring(startIndex).trim();
        // Đọc nội dung từ tập tin JSON
        String? jsonData = await apiGetAllVehicles.getAllVehicles(token); // Đọc dữ liệu từ tập tin JSON

        Map<String, dynamic> jsonDataMap = json.decode(jsonData!);

        List<dynamic> itemsList = jsonDataMap['items'];
        print(itemsList);
        setState(() {
          items = itemsList;
        });// Đọc dữ liệu từ tập tin JSON
      }
      // Chuyển đổi chuỗi JSON thành danh sách đối tượng

    } catch (e) {
      print('Đã xảy ra lỗi khi đọc tập tin JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Danh sách các mục từ JSON:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('License Plate: ${items[index]['license_plate']}'),
                  subtitle: Text('Vehicle Type: ${items[index]['vehicle_type']}'),
                  // Hiển thị các trường dữ liệu tương ứng từ từng đối tượng trong danh sách
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
