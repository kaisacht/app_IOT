
import 'dart:convert';

import 'package:http/http.dart' as http;

class APISparkingLots {
  var client = http.Client();
  Future<String?> getAllSparkingSpace(String token, String showDelete, String showFreeOnly, dynamic page, dynamic size) async {
    var url = Uri.parse("http://172.17.176.1:8000/parking_spaces/?parking_lot_id=1&show_deleted=$showDelete&show_free_only=$showFreeOnly&page=$page&size=$size");
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          //'Content-Type': 'application/json'
        }, // Set the content type
        //body: formData, // Pass the JSON string as the body
      );
      return response.body;
    } catch (error) {
      return null;
    }
  }
  Future<dynamic> postReserveSpace(int id, int vehicleId) async {
    var url = Uri.parse("http://172.17.176.1:8001/reserve");
    var formData = {
      "parking_space_id": id,
      "vehicle_id": vehicleId,
    };
    String jsonData = jsonEncode(formData);
    try {
      var response = await http.post(
        url,
        headers: {
        //   'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        }, // Set the content type
        body: jsonData, // Pass the JSON string as the body
      );
      return response.statusCode;
    } catch (error) {
      return null;
    }
  }
}