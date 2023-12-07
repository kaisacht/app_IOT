import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: const Color(0x00000000),
          body: Column(children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * .4,
                  width: size.width,
                ),
                gradientContainer(size),
                Positioned(
                    top: size.height * .15,
                    left: 30,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bãi đỗ xe thông minh",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              "Rooms",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                          ),
                          Row(children: [
                            customCard(size,context),
                            customCard(size,context),
                            customCard(size,context),
                          ]),
                        ]))
              ],
            ),
            DevicesGridDashboard(size: size),
            const ScenesDashboard()
          ]));
    });
  }

  Padding customCard(Size size, context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Rooms(),)),
        child: Container(
          height: size.height * .15,
          width: size.width * .5,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/bg.jpg",
                ),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: size.height * .12),
              child: const Text(
                'Room',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container gradientContainer(Size size) {
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              //secondaryColor.withOpacity(0.9),
              //primaryColor.withOpacity(0.9)
            ])),
      ),
    );
  }
}

class ScenesDashboard extends StatelessWidget {
  const ScenesDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 30),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Scenes",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //CardWidget(icon: Icon(Icons.home_work_rounded,color: secondaryColor,), title: 'Coming Home'),
                //CardWidget(icon: Icon(Icons.home,color: secondaryColor,), title: 'At Home')
              ],
            ),
          )
        ],),);
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

class DevicesGridDashboard extends StatelessWidget {
  const DevicesGridDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "Devices",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.construction,
                  color: Colors.green,
                ),
                label: Text('GGGGGG', style: TextStyle(fontSize: 25),),)
              //   child: const Text('Gradient'),)
              // // cardField(
              //     size,
              //     Colors.blue,
              //     const Icon(
              //       Icons.camera_outlined,
              //       color: Colors.white,
              //     ),
              //     'Cameras',
              //     '8 Devices'),
              // cardField(
              //     size,
              //     Colors.amber,
              //     const Icon(Icons.lightbulb_outline, color: Colors.white),
              //     'Lights',
              //     '8 Devices'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardField(
                  size,
                  Colors.orange,
                  const Icon(Icons.music_note_outlined, color: Colors.white),
                  'Speakers',
                  '2 Devices'),
              cardField(
                  size,
                  Colors.teal,
                  const Icon(Icons.sports_cricket_sharp, color: Colors.white),
                  'Cricket bat',
                  '8 Devices'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardField(
                  size,
                  Colors.purple,
                  const Icon(Icons.wifi_outlined, color: Colors.white),
                  'Sensors',
                  '5 Devices'),
              cardField(
                  size,
                  Colors.green,
                  const Icon(Icons.air_outlined, color: Colors.white),
                  'Air Condition',
                  '4 Devices'),
            ],
          )
        ],
      ),
    );
  }
}

cardField(
    Size size,
    Color color,
    Icon icon,
    String title,
    String subtitle,
    ) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
        child: SizedBox(
            height: size.height * .1,
            width: size.width * .39,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color,
                  child: icon,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ))),
  );
}