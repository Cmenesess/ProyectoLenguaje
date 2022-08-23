// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'package:flutter/material.dart';
import 'package:sava_mobile/widgets/text_dialog_widget.dart';

import '../models/dosage_model.dart';
import '../utils/create_cell.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(minHeight: 200),
                alignment: Alignment.center,
                child: Icon(Icons.person, size: 200),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orange)),
            SizedBox(height: 50),
            Row(children: [
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: Text('Correo: ', style: TextStyle(fontSize: 20))),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text("miguel@espol.edu.ec",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis),
              )
            ]),
            SizedBox(height: 20),
            Row(children: [
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: Text('Teléfono: ', style: TextStyle(fontSize: 20))),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Text("098987674",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
