import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadFile {
  Future<String?> readDataFromFile() async {
    String content = '';
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/dataUser.txt');
      if (await file.exists()) {
        content = await file.readAsString();
      } else {
        print('Tập tin không tồn tại.');
      }
      return content;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getNameUser() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/dataUser.txt');
      if (await file.exists()) {
        String content = await file.readAsString();
        int startIndex = content.indexOf('Username: ');
        if (startIndex != -1) {
          startIndex += 'Username: '.length;
          int endIndex = content.indexOf('Password: ', startIndex);
          if (endIndex != -1) {
            String name = content.substring(startIndex, endIndex).trim();
            return name;
          } else {
            // Chuỗi "Password: " không được tìm thấy trong nội dung tệp tin
            // Xử lý trường hợp này tại đây, ví dụ: throw một Exception hoặc trả về giá trị mặc định
            return null;
          }
        } else {
          // Chuỗi "Username: " không được tìm thấy trong nội dung tệp tin
          // Xử lý trường hợp này tại đây, ví dụ: throw một Exception hoặc trả về giá trị mặc định
          return null;
        }
      } else {
        // Tệp tin không tồn tại
        return null;
      }
    } catch (e) {
      // Xử lý ngoại lệ khi đọc tệp tin gặp vấn đề
      return null;
    }
  }
}