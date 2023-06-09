import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tres_det/authentication/authentication_services.dart';
import 'package:tres_det/components/cards.dart';
import 'package:tres_det/screens/image_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TresDet",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          TextButton(
            child: Text(
              "signout",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () async {
              var result = await signOut();
              if (result == "signout successfull") {
                Navigator.pushReplacementNamed(context, "signin_page");
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: collectionStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: SortedInformation(snapshot),
            );
          }),
    );
  }
}

class DayWiseInformation extends StatelessWidget {
  const DayWiseInformation(
      {super.key,
      required this.date,
      required this.tresspasserAlerts,
      required this.publicImgUrl});

  final String date;
  final Map<String, dynamic> tresspasserAlerts;
  final String publicImgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // push to img screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetectedImageScreen(imgUrl: publicImgUrl)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        // color: Color.fromARGB(255, 205, 59, 59),
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
      ),
    );
  }
}

List<Widget> SortedInformation(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  List<QueryDocumentSnapshot<Object?>> detectionList = []
    ..addAll(snapshot.data!.docs);

  detectionList.sort((a, b) {
    Map<String, dynamic> data1 = a.data() as Map<String, dynamic>;
    Map<String, dynamic> data2 = b.data() as Map<String, dynamic>;
    return data2['Date']
        .compareTo(data1['Date']); // since we want in descending order
  });

  print(snapshot.data!.docs
      .map((doc) => doc.data()! as Map<String, dynamic>)
      .toList());

  return detectionList.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return DayWiseInformation(
      date: data["Date"],
      tresspasserAlerts: data,
      publicImgUrl: data["PublicUrl"],
    );
  }).toList();
}
