// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../widgets/warehouse_package_widget.dart';

class HistorialClientScreen extends StatefulWidget {
  const HistorialClientScreen({Key? key}) : super(key: key);

  @override
  State<HistorialClientScreen> createState() => _HistorialClientScreenState();
}

void updateId(int newId) {}

class _HistorialClientScreenState extends State<HistorialClientScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Card(
            color: Color.fromARGB(255, 177, 206, 229),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Ingrese su código",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 15, 96, 162)),
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
                            color: Color.fromARGB(255, 6, 37, 62),
                            width: 3,
                          )),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(),
                        ),
                        Icon(Icons.search)
                      ]),
                    ),
                  )
                ],
              ),
            )),
        Text(
          "Historial de Paquetes",
          style:
              TextStyle(fontSize: 30, color: Color.fromARGB(255, 22, 102, 168)),
        ),
        // WarehousePackageWidget(
        //   addPackage: updateId,
        //   removePackage: (int newId) {},
        //   needCheck: false,
        // ),
        // WarehousePackageWidget(
        //   addPackage: updateId,
        //   removePackage: (int newId) {},
        //   needCheck: false,
        // ),
        // WarehousePackageWidget(
        //   addPackage: updateId,
        //   removePackage: (int newId) {},
        //   needCheck: false,
        // ),
      ]),
    );
  }
}
