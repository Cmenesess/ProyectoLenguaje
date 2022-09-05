// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/warehouse_package_provider.dart';
import '../../widgets/sava_package_widget.dart';
import '../../widgets/warehouse_package_widget.dart';

class SavaPackagesClientScreen extends StatefulWidget {
  const SavaPackagesClientScreen({Key? key}) : super(key: key);

  @override
  State<SavaPackagesClientScreen> createState() =>
      _SavaPackagesClientScreenState();
}

class _SavaPackagesClientScreenState extends State<SavaPackagesClientScreen> {
  List<dynamic> packages = [];

  //Shared Preferences
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response = await WarehousePackageProvider.getSavaPackages(token!);
      packages = response;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 120,
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.indigo[900], boxShadow: [
            BoxShadow(
              offset: Offset(3, 0),
              spreadRadius: -3,
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 1),
            )
          ]),
          child: SafeArea(
            child: Text(
              "Paquetes SAVA",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
            child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                "Ingrese su código",
                style: TextStyle(fontSize: 30, color: Colors.indigo[900]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // color: Color.fromARGB(255, 58, 113, 158),
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 3,
                      )),
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          print(value);
                          dynamic newList = [];
                          if (value == '') {
                            Future.delayed(Duration.zero, () async {
                              prefs = await SharedPreferences.getInstance();
                              String? token = prefs.getString('token');
                              dynamic response = await WarehousePackageProvider
                                  .getSavaPackages(token!);
                              packages = response;
                              setState(() {});
                            });
                            newList = packages;
                          } else {
                            for (dynamic element in packages) {
                              if (element['sava_code'].contains(value)) {
                                newList.add(element);
                              }
                            }
                          }
                          setState(() {
                            packages = newList;
                          });
                        },
                      ),
                    ),
                    Icon(Icons.search)
                  ]),
                ),
              )
            ],
          ),
        )),
        Text(
          "Paquetes Sava",
          style: TextStyle(fontSize: 30, color: Colors.indigo[900]),
        ),
        ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: packages.length,
            itemBuilder: (context, index) {
              return SavaPackageWidget(details: packages[index]);
            })
      ]),
    );
  }
}
