import 'package:first_app/api/APIDeleteVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:first_app/view/GetAllVehicles.dart';
import 'package:flutter/material.dart';

class CardItemVehicles extends StatelessWidget {
  final APIDeleteVehicles apiDeleteVehicles = APIDeleteVehicles();
  final ReadFile readFile = ReadFile();
  final String licensePlate;
  final String vehicleType;
  final int id;

   CardItemVehicles({
    Key? key,
    required this.licensePlate,
    required this.vehicleType,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biển số xe: $licensePlate',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Loại phương tiện: $vehicleType',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Cảnh báo'),
                        content: const Text('Bạn có muốn xóa?'),
                        actions: [
                          TextButton(
                            child: const Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng cửa sổ cảnh báo
                            },
                          ),
                          TextButton(
                            child: const Text('Xác nhận'),
                            onPressed: () async {
                              try {
                                String? content = await readFile.readDataFromFile();
                                if(content !=null) {
                                  int startIndex = content.indexOf('Token: ') + 'Token: '.length;
                                  String token = content.substring(startIndex).trim();
                                  int code  = await apiDeleteVehicles.apiDeleteVehicle(token, id);
                                  if ( code  == 204){
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GetAllVehiclesPage(),
                                      ),
                                    );

                                  }
                                }
                              } catch (e) {
                                //print('Đã xảy ra lỗi khi đọc tập tin JSON: $e');
                              }
                              // Thực hiện hành động xóa nếu người dùng xác nhận// Đóng cửa sổ cảnh báo
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
