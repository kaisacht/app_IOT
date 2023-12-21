import 'dart:convert';
import 'package:http/http.dart' as http;

class APIGetAllRating{
  var client = http.Client();
  Future<String?> getAllRating(String token) async {
    var url = Uri.parse("http://172.17.176.1:8000/activity_logs/");
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