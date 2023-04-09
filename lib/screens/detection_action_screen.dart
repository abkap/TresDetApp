import 'package:flutter/material.dart';
import 'package:tres_det/authentication/authentication_services.dart';
import 'package:tres_det/components/cards.dart';
import 'package:tres_det/components/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
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
            ListView(
              children: [
                DayWiseInformation(
                  date: "Today",
                ),
                DayWiseInformation(
                  date: "Yestarday",
                ),
              ],
            ),
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
  const DayWiseInformation({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      // color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Center(
              child: Text(
            date,
            style: TextStyle(color: Colors.grey, fontSize: 18.0),
          )),
          AlertInformationCard(),
          AlertInformationCard(),
        ],
      ),
    );
  }
}
