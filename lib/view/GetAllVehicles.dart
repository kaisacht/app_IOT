import 'dart:convert';
import 'package:first_app/api/APIVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:first_app/view/CardItemsVehicles.dart';
import 'package:first_app/view/HomeUser.dart';
import 'package:flutter/material.dart';

class GetAllVehiclesPage extends StatefulWidget {
  const GetAllVehiclesPage({super.key});

  @override

  _GetAllVehiclesPage createState() =>
      _GetAllVehiclesPage();
}

class _GetAllVehiclesPage extends State<GetAllVehiclesPage> {
  final ReadFile readFile = ReadFile();
  final APIVehicles apiVehicles = APIVehicles();
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
        int startIndex = content.indexOf('Token: ') + 'Token: '.length;
        String token = content.substring(startIndex).trim();
        // Đọc nội dung từ tập tin JSON
        String? jsonData = await apiVehicles.getAllVehicles(token); // Đọc dữ liệu từ tập tin JSON

        Map<String, dynamic> jsonDataMap = json.decode(jsonData!);

        List<dynamic> itemsList = jsonDataMap['items'];
        setState(() {
          items = itemsList;
        });// Đọc dữ liệu từ tập tin JSON
      }
      // Chuyển đổi chuỗi JSON thành danh sách đối tượng

    } catch (e) {
      //print('Đã xảy ra lỗi khi đọc tập tin JSON: $e');
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
            Navigator.push(context,
              // context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Các loại phương tiện đã đăng ký',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return CardItemVehicles(
                  licensePlate: items[index]['license_plate'],
                  vehicleType: items[index]['vehicle_type'],
                  id: items[index]['id'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
