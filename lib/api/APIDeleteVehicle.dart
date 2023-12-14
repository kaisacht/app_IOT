import 'dart:convert';
import 'package:http/http.dart' as http;

class APIDeleteVehicles{
  var client = http.Client();
  Future<int> apiDeleteVehicle(String token, int id) async {
    var url = Uri.parse("http://172.17.176.1:8000/vehicles/$id");
    try {
      var response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          //'Content-Type': 'application/json'
          }, // Set the content type
        //body: formData, // Pass the JSON string as the body
      );
      return response.statusCode;
    } catch (error) {
      return 0;
    }
  }
}