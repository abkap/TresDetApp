import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tres_det/authentication/authentication_services.dart';
import 'package:tres_det/components/cards.dart';
import 'package:tres_det/components/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  late Stream<QuerySnapshot> collectionStream;
  void initState() {
    // TODO: implement initState
    collectionStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: TextButton(
                child: Text("signout"),
                onPressed: () async {
                  var result = await signOut();
                  if (result == "signout successfull") {
                    Navigator.pushReplacementNamed(context, "signin_page");
                  }
                },
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "TresDet",
            style: TextStyle(fontSize: 25),
          ),
          bottom: TabBar(tabs: [
            TabBarText("Detections"),
            TabBarText("Actions"),
          ]),
        ),
        body: TabBarView(
          children: [
            // first tabbar view content
            // detection view

            StreamBuilder<QuerySnapshot>(
                stream: collectionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return DayWiseInformation(
                        date: data["Date"],
                        tresspasserAlerts: data,
                      );
                    }).toList(),
                  );
                  // return ListView(
                  //   children: [
                  //     DayWiseInformation(
                  //       date: "Today",
                  //     ),
                  //     DayWiseInformation(
                  //       date: "Yestarday",
                  //     ),
                  //   ],
                  // );
                }),
            // next tabbar view
            ListView(
              children: [
                ActionInformationCard(
                  animalName: "Birds",
                  detectionType: "Ultrasonic sound : 50KHz",
                ),
                ActionInformationCard(
                  animalName: "Birds",
                  detectionType: "Ultrasonic sound : 50KHz",
                ),
                ActionInformationCard(
                  animalName: "Birds",
                  detectionType: "Ultrasonic sound : 50KHz",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DayWiseInformation extends StatelessWidget {
  const DayWiseInformation(
      {super.key, required this.date, required this.tresspasserAlerts});

  final String date;
  final Map<String, dynamic> tresspasserAlerts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      // color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Center(
              child: Text(
            date.split(" ")[0], // Date only
            style: TextStyle(color: Colors.grey, fontSize: 18.0),
          )),
          AlertInformationCard(
              dateTime: tresspasserAlerts['Date'],
              animal: tresspasserAlerts["AnimalName"],
              accuracy: tresspasserAlerts["Accuracy"]),
        ],
      ),
    );
  }
}
