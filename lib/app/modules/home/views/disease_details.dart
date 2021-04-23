import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils.dart';

class DiseaseDetails extends StatelessWidget {
  final String plant;
  final String disease;

  const DiseaseDetails({Key key, this.plant, this.disease}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String image = data[plant][disease]['image'];
    final String info = data[plant][disease]['info'];
    final List<String> remedies = data[plant][disease]['remedies'];
    return Scaffold(
      appBar: AppBar(
        title: Text(disease),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
              child: Image.asset(
            image,
            fit: BoxFit.cover,
          )),
          Text(
            disease,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).marginAll(10),
          Text(
            info,
            style: TextStyle(fontWeight: FontWeight.w600),
          ).marginAll(10),
          Text(
            "Remedies",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).marginAll(10),
          for (var i = 0; i < remedies.length; i++)
            Text(remedies[i]).marginAll(10),
        ],
      ),
    );
  }
}
