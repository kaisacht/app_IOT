import 'dart:convert';
import 'package:http/http.dart' as http;

class APIRatingFeedbacks {
  var client = http.Client();
  Future<int> postRatingFeedbacks (String rate, String review, String parkingLotsId, String token) async {
    // Replace this URL with your endpoint
    var url = Uri.parse("http://172.17.176.1:8000/parking-lots/$parkingLotsId/rating-feedbacks/");
    // Replace these with your form data
    var formData = {
      "rating": rate,
      "feedback": review,
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

  Future<String?> getAllRating(String token, dynamic parkingLotsId) async {
    var url = Uri.parse("http://172.17.176.1:8000/parking-lots/$parkingLotsId/rating-feedbacks/");
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