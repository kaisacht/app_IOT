import 'package:first_app/api/APIVehicle.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:first_app/loginandsignup/Login.dart';
import 'package:first_app/view/GelAllActivityLogs.dart';
import 'package:first_app/view/GetAllVehicles.dart';
import 'package:first_app/view/SeeAndReviewPackingLot.dart';
import 'package:first_app/view/SeePackingLot.dart';
import 'package:flutter/material.dart';

import 'CreateVehicles.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ReadFile readFile = ReadFile();
  String userName = '';
  @override
  void initState() {
    super.initState();
    getName();
  }
  void getName() async {
    String? name = await readFile.getNameUser();
    if (name != null) {
      setState(() {
        userName = name;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Xin chào $userName',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        'assets/images/bgpackinglot.png',
                        scale: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'Bãi đỗ xe thông minh',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'SERVICES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SeeParkingLotPage(),
                              ),
                            );
                          },
                          icon: 'assets/images/view_detail.png',
                          title: 'Xem bãi đỗ xe',
                        ),
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateVehiclesPage(),
                              ),
                            );
                          },
                          icon: 'assets/images/add_device.png',
                          title: 'Thêm mới phương tiện',
                          //color: Colors.indigoAccent,
                          //fontColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28, width: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GetAllActivityLogs(),
                              ),
                            );
                          },
                          icon: 'assets/images/history_log.png',
                          title: 'Xem lịch sử hoạt động',
                        ),
                        _cardMenu(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetAllVehiclesPage(),
                              ),
                            );
                          },
                          icon: 'assets/images/management.png',
                          title: 'Quản lý phương tiện',
                        ),
                      ],
                    ),
                    const SizedBox(height: 28, width: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReviewParkingLotPage(),
                              ),
                            );
                          },
                          icon: 'assets/images/icon_review.png',
                          title: 'Xem đánh giá',
                        ),

                        _cardMenu(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          icon: 'assets/images/logout.png',
                          title: 'Đăng xuất',
                        ),
                      ],
                    ),
                    const SizedBox(height: 28, width: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          icon: 'assets/images/other.png',
                          title: 'Tính năng khác',
                        ),

                        // _cardMenu(
                        //   onTap: (){
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => LoginPage(),
                        //       ),
                        //     );
                        //   },
                        //   icon: 'assets/images/logout.png',
                        //   title: 'Đăng xuất',
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.black54,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 36,
        ),
        width: 156,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  const CardWidget({
    Key? key,
    required this.icon,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50,
        width: 200,
        child: Center(child: ListTile(leading: icon,title: Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),),),
      ),
    );
  }
}
