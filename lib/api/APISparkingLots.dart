
import 'package:http/http.dart' as http;

class APISparkingLots {
  var client = http.Client();
  Future<String?> getAllSparkingSpace(String token, String showDelete, String showFreeOnly, dynamic page, dynamic size) async {
    var url = Uri.parse("http://172.17.176.1:8000/parking_spaces/?show_deleted=$showDelete&show_free_only=$showFreeOnly&page=$page&size=$size");
    print(url);
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          //'Content-Type': 'application/json'
        }, // Set the content type
        //body: formData, // Pass the JSON string as the body
      );
      print(response.body);
      return response.body;
    } catch (error) {
      return null;
    }
  }
}