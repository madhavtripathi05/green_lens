import 'package:flutter/material.dart';
import 'package:green_lens/app/modules/home/views/disease_details.dart';
import 'package:green_lens/utils.dart';
import 'package:get/get.dart';

class DiseasesView extends StatelessWidget {
  final String plant;

  const DiseasesView({Key key, this.plant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant.toUpperCase()), centerTitle: true),
      body: ListView.builder(
        itemCount: data[plant].entries.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            onTap: () => Get.to(() => DiseaseDetails(
                  plant: plant,
                  disease: data[plant].entries.elementAt(i).key,
                )),
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                    data[plant].entries.elementAt(i).value['image'])),
            title: Text(data[plant].entries.elementAt(i).key),
            subtitle: Text('${data[plant].entries.elementAt(i).value['info']}'
                .split('.')
                .first),
          ),
        ),
      ),
    );
  }
}
