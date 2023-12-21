import 'dart:math';

import 'package:flutter/material.dart';

class ReviewParkingLotPage extends StatefulWidget {
  const ReviewParkingLotPage({Key? key}) : super(key: key);

  @override
  _ReviewParkingLotPageState createState() => _ReviewParkingLotPageState();
}

class _ReviewParkingLotPageState extends State<ReviewParkingLotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá ứng dụng'),
      ),
      body: ListView.builder(
        itemCount: 10, // Số lượng đánh giá (ví dụ 10 đánh giá)
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                // Ảnh đại diện người đánh giá (có thể làm việc khác)
                backgroundImage: AssetImage('assets/images/icon_avatar.png'),
              ),
              title: Text(
                'Người dùng $index',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 4.0),
                  // Đánh giá sao (có thể thay thế bằng StarRating package)
                  Row(
                    children: List.generate(
                      5,
                          (i) => Icon(
                        i < 4 ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Đánh giá và nhận xét về ứng dụng...',
                    style: TextStyle(color: Colors.grey[600]),
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
    );
  }
}
