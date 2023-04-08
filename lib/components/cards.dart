import 'package:flutter/material.dart';

class AlertInformationCard extends StatelessWidget {
  const AlertInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text("Elephant detected in farm field 1"),
          trailing: Text("11:29 Am"),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

class ActionInformationCard extends StatelessWidget {
  const ActionInformationCard({
    super.key,
    required this.animalName,
    required this.detectionType,
  });
  final String animalName;
  final String detectionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
      padding: EdgeInsets.all(10.0),
      child: Column(children: [
        ListTile(
          leading: null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animalName,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                detectionType,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          trailing: TextButton(
            child: Text("Edit"),
            onPressed: () {},
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ]),
    );
  }
}
