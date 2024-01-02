import 'dart:math';

import 'package:first_app/api/APIVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:flutter/material.dart';

class SeeParkingLotPage extends StatefulWidget {
  const SeeParkingLotPage({Key? key}) : super(key: key);

  @override
  _SeeParkingLotPageState createState() => _SeeParkingLotPageState();
}

class _SeeParkingLotPageState extends State<SeeParkingLotPage> {

  List<int> randomValues = List.generate(200, (index) => Random().nextInt(3));
  String selectedVehicle = '';
  List<dynamic> vehicleNames = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ bãi đỗ xe'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/bgpackinglot.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Lối đi vào',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 2 / 1,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 10,
                    ),delegate: SliverChildBuilderDelegate(
                        (BuildContext ctx, index) {
                          Color color;
                          switch (randomValues[index]) {
                            case 0:
                              color = Colors.red;
                              break;
                            case 1:
                              color = Colors.green;
                              break;
                            case 2:
                              color = Colors.yellow;
                              break;
                            default:
                              color = Colors.black; // Màu mặc định nếu giá trị không phù hợp
                              break;
                          }
                      return _cardMenu(
                        color: color, // Thêm thuộc tính màu sắc cho phần tử `_cardMenu`
                        onTap: () async {
                          String? token = await ReadFile().getToken();
                          vehicleNames = (await (APIVehicles().getVehicleName(token!)))!;
                          if (color == Colors.green) {
                            print(vehicleNames);
                            selectedVehicle = vehicleNames.first;
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250, // Tăng chiều cao để chứa combobox
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Bạn có muốn đặt chỗ này?',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Text('Chọn phương tiện: '),
                                            DropdownMenu<dynamic>(
                                              initialSelection: selectedVehicle,
                                              onSelected: (dynamic? value) {
                                                setState(() {
                                                  selectedVehicle = value!;
                                                });
                                              },       dropdownMenuEntries: vehicleNames.map<DropdownMenuEntry<dynamic>>((dynamic value) {
                                              return DropdownMenuEntry<String>(value: value, label: value);
                                            }).toList(),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 120, // Đặt độ rộng của nút
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green, // Màu nền của nút "Xác nhận"
                                                ),
                                                child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Container(
                                              width: 120, // Đặt độ rộng của nút
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red, // Màu nền của nút "Hủy"
                                                ),
                                                child: const Text('Hủy', style: TextStyle(color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                          } else if (color == Colors.green)
                            print("app nhu lon");
                          else
                            print("app nhu dau buoi");
                          // Xử lý khi người dùng nhấn vào vị trí đỗ xe
                          // Ví dụ: Hiển thị chi tiết vị trí đỗ xe
                        },
                      );
                    },
                    childCount: randomValues.length,
                  ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  const Text(
                    'Đang trống',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  const Text(
                    'Đã có xe đậu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  const Text(
                    'Đã đặt chỗ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget _cardMenu({
  //required String title,
  //required Icon icon,
  VoidCallback? onTap,
  Color color = Colors.white,
  Color fontColor = Colors.black,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8, // Giảm khoảng cách dọc
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      // child: Column(
      //   children: [
      //     icon,
      //     const SizedBox(height: 10),
      //     // Text(
      //     //   title,
      //     //   style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
      //     // )
      //   ],
      // ),
    ),
  );
}


