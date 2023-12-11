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
}

