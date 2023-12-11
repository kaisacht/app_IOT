import 'dart:convert';
import 'package:http/http.dart' as http;

class APIGetAllVehicles{
  var client = http.Client();
  Future<String?> getAllVehicles(String token) async {
    var url = Uri.parse("http://172.17.176.1:8000/vehicles/");
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',}
      );
      return response.body;
    } catch (error) {
      return null;
    }
  }
}