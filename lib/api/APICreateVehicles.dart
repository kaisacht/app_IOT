import 'dart:convert';
import 'package:http/http.dart' as http;

class APICreateVehicles {
  var client = http.Client();
  Future<int> getCodeCreateVehicles(String licensePlate, String vehicleType, String token) async {
    // Replace this URL with your endpoint
    var url = Uri.parse("http://172.17.176.1:8000/vehicles/");
    // Replace these with your form data
    var formData = {
      "license_plate": licensePlate,
      "vehicle_type": vehicleType,
    };
    String jsonData = jsonEncode(formData);
    try {
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'}, // Set the content type
        body: jsonData, // Pass the JSON string as the body
      );
      return response.statusCode;
    } catch (error) {
      return 0;
    }
  }
  //
  // Future<int> getCodeLogin(String name, String password) async {
  //   // Replace this URL with your endpoint
  //   var url = Uri.parse("http://172.17.176.1:8000/login");
  //   // Replace these with your form data
  //   var formData = {
  //     "username": name,
  //     "password": password,
  //   };
  //   //String jsonData = jsonEncode(formData);
  //   try {
  //     var response = await http.post(
  //       url,
  //       //headers: {'Content-Type': 'application/json'}, // Set the content type
  //       body: formData, // Pass the JSON string as the body
  //     );
  //     return response.statusCode;
  //   } catch (error) {
  //     return 0;
  //   }
  // }
}