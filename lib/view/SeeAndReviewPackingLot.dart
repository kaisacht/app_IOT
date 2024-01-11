import 'dart:convert';
import 'package:first_app/api/APIRatingFeedbacks.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:first_app/view/HomeUser.dart';
import 'package:flutter/material.dart';

class ReviewParkingLotPage extends StatefulWidget {
  const ReviewParkingLotPage({Key? key}) : super(key: key);



  @override
  _ReviewParkingLotPageState createState() => _ReviewParkingLotPageState();
}

class _ReviewParkingLotPageState extends State<ReviewParkingLotPage> {

  final APIRatingFeedbacks apiRatingFeedbacks = APIRatingFeedbacks();
  final ReadFile readFile = ReadFile();
  List<dynamic> items = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadItemsFromJson();
  }

  Future<void> loadItemsFromJson() async {
    try {
      String? content = await readFile.readDataFromFile();
      if(content !=null) {
        int startIndex = content.indexOf('Token: ') + 'Token: '.length;
        String token = content.substring(startIndex).trim();
        // Đọc nội dung từ tập tin JSON
        String? jsonData = await apiRatingFeedbacks.getAllRating(token,1); // Đọc dữ liệu từ tập tin JSON

        Map<String, dynamic> jsonDataMap = json.decode(jsonData!);

        List<dynamic> itemsList = jsonDataMap['items'];
        setState(() {
          items = itemsList;
        });// Đọc dữ liệu từ tập tin JSON
      }
      // Chuyển đổi chuỗi JSON thành danh sách đối tượng

    } catch (e) {
      //print('Đã xảy ra lỗi khi đọc tập tin JSON: $e');
    }
  }
  List<dynamic> rateStar = ['1','2', '3', '4', '5'];
  String selectStar = '1';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá ứng dụng'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
          icon: const Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        )
      ),
      body: ListView.builder(
        itemCount: items.length, // Số lượng đánh giá (ví dụ 10 đánh giá)
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const CircleAvatar(
                // Ảnh đại diện người đánh giá (có thể làm việc khác)
                backgroundImage: AssetImage('assets/images/icon_avatar.png'),
              ),
              title: Text(
                items[index]['user']['username'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 4.0),
                  // Đánh giá sao (có thể thay thế bằng StarRating package)
                  Row(
                    children: List.generate(
                      5,
                          (i) => Icon(
                        i < items[index]['rating'] ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                      items[index]['feedback'] ?? 'Không có đánh giá',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.grey[600]),
                  ),
                ],
              ),
              onTap: () {
                // Xử lý khi người dùng nhấn vào đánh giá cụ thể
                // Ví dụ: Hiển thị chi tiết đánh giá
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {// Giá trị mặc định cho số sao được chọn
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 720,
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Viết bài đánh giá',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Đánh giá: '),
                        DropdownMenu<dynamic>(
                          initialSelection: selectStar,
                          onSelected: (dynamic value) {
                            setState(() {
                              selectStar = value!;
                            });
                          },       dropdownMenuEntries: rateStar.map<DropdownMenuEntry<dynamic>>((dynamic value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: textEditingController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Nhập đánh giá của bạn...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () async {
                              String? token = await readFile.getToken();
                              apiRatingFeedbacks.postRatingFeedbacks(selectStar, textEditingController.text, '1', token!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReviewParkingLotPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              // Xử lý khi người dùng nhấn nút "Hủy"
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            child: const Text('Hủy', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),

    );
  }
}
