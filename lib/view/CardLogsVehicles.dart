import 'package:first_app/api/APIDeleteVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:first_app/view/GetAllVehicles.dart';
import 'package:flutter/material.dart';

class CardLogsVehicles extends StatelessWidget {
  final APIDeleteVehicles apiDeleteVehicles = APIDeleteVehicles();
  final ReadFile readFile = ReadFile();
  final String licensePlate;
  final String timestamp;
  final String activity_type;
  final String vehicle_type;

  CardLogsVehicles({
    Key? key,
    required this.licensePlate,
    required this.timestamp,
    required this.activity_type,
    required this.vehicle_type,
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
                    'Hoạt động: $activity_type',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Thời gian: ${timestamp.toString()}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Loại phương tiện: ${vehicle_type.toString()}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
