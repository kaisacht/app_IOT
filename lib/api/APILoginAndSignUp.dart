import 'dart:convert';
import 'package:http/http.dart' as http;
const String baseUrl = 'http://localhost:8000/login';

class BaseClient {
  var client = http.Client();
  Future<int> getCodeRegister(String name, String password) async {
    // Replace this URL with your endpoint
    var url = Uri.parse("http://172.17.176.1:8000/users/");
    // Replace these with your form data
    var formData = {
      "username": name,
      "password": password,
    };
    String jsonData = jsonEncode(formData);
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'}, // Set the content type
        body: jsonData, // Pass the JSON string as the body
      );
      return response.statusCode;
    } catch (error) {
      return 0;
    }
  }

  Future<int> getCodeLogin(String name, String password) async {
    // Replace this URL with your endpoint
    var url = Uri.parse("http://172.17.176.1:8000/login");
    // Replace these with your form data
    var formData = {
      "username": name,
      "password": password,
    };
    //String jsonData = jsonEncode(formData);
    try {
      var response = await http.post(
        url,
        //headers: {'Content-Type': 'application/json'}, // Set the content type
        body: formData, // Pass the JSON string as the body
      );
      return response.statusCode;
    } catch (error) {
      return 0;
    }
  }
}