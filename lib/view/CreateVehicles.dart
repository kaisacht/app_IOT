import 'package:first_app/alert/AlerCreateVehiclesFail.dart';
import 'package:first_app/alert/AlerCreateVehiclesSuccess.dart';
import 'package:first_app/alert/AlertRegisterSuccess.dart';
import 'package:first_app/api/APICreateVehicles.dart';
import 'package:first_app/info/ReadFile.dart';
import 'package:flutter/material.dart';

class CreateVehiclesPage extends StatefulWidget {
  @override

  _CreateVehiclesPage createState() =>
      _CreateVehiclesPage();
}
class _CreateVehiclesPage extends State<CreateVehiclesPage> {
  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final APICreateVehicles apiCreateVehicles = APICreateVehicles();
  final ReadFile readFile = ReadFile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Column(
                children: <Widget>[
                  Text("Đăng ký thêm mới",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 20,),
                ],
              ),
              Column(
                children: <Widget>[
                  TextFormField(
                    controller: licensePlateController,
                    decoration: const InputDecoration(
                      labelText: 'Biển số xe',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: vehicleTypeController,
                    //obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Loại xe',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: Column(
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        String licensePlate = licensePlateController.text;
                        String vehicleType = vehicleTypeController.text;
                        String? content = await readFile.readDataFromFile();
                        if(content !=null){
                          int startIndex = content.indexOf('Token: ') + 'Token: '.length;
                          String token = content.substring(startIndex).trim();
                          if(licensePlate.isEmpty || vehicleType.isEmpty){
                            showAlertDialogCreateVehiclesFailBecauseNull(context);
                          }else{
                            int code = await apiCreateVehicles.getCodeCreateVehicles(licensePlate, vehicleType,token);
                            if(code == 201){
                              licensePlateController.text = '';
                              vehicleTypeController.text = '';
                              showAlertDialogCreateVehiclesSuccess(context);
                            }else {
                              showAlertDialogCreateVehiclesFail(context);
                            }
                          }
                        }
                      },
                      color: const Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Xác nhận",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                    ),
                    const SizedBox(height:20),

                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        licensePlateController.text = '';
                        vehicleTypeController.text = '';
                      },
                      color: const Color.fromRGBO(64, 64, 64, 1.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Hủy",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
