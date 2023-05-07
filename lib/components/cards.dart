import 'dart:ffi';

import 'package:flutter/material.dart';

class AlertInformationCard extends StatelessWidget {
  const AlertInformationCard(
      {super.key,
      required this.dateTime,
      required this.animal,
      required this.accuracy});
  final String dateTime;
  final String animal;
  final double accuracy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
              "${animal} detected ( ${(accuracy * 100).toStringAsFixed(2)} ) !!"),
          trailing: Text(dateTime.split(" ")[1]),
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
