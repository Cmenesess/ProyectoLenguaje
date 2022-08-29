// ignore_for_file: prefer_const_constructors, always_specify_types, use_build_context_synchronously, unused_local_variable,prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/warehouse_package_provider.dart';
import '../../widgets/warehouse_package_widget.dart';

class PackagesClientScreen extends StatefulWidget {
  const PackagesClientScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PackagesClientScreen> createState() => _PackagesClientScreenState();
}

class _PackagesClientScreenState extends State<PackagesClientScreen> {
  dynamic packages = [];
  dynamic price = 0.0;
  dynamic packages_availables = [];

  void addPackage(String newId, double addPrice) {
    setState(() {
      packages.add(newId);
      price += addPrice;
      print(price);
    });
  }

  void deletePackage(String newId, double minusPrice) {
    setState(() {
      packages.remove(newId);
      price -= minusPrice;
    });
  }

  //Shared Preferences
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response =
          await WarehousePackageProvider.getWarehousePackages(token!);
      packages_availables = response;
      setState(() {});
    });
  }

  void createSava() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: const Text(
                'Desea enviar todos esos paquetes seleccionados a Ecuador?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    var response =
                        await WarehousePackageProvider.createSavaPackages(
                            packages);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Paquete creado correctamente')));
                    Navigator.popAndPushNamed(context, "home_client");
                  },
                  child: Text("Si")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Selecciona los paquetes a enviar",
            style: TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 22, 102, 168)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Total \$ $price",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () async {
                if (packages.length > 0) {
                  createSava();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Debe seleccionar al menos un paquete')));
                }
              },
              child: Text(
                "NumeroSeleccionados (${packages.length})",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
      ListView.builder(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: packages_availables.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return WarehousePackageWidget(
              tracking_number: packages_availables[index]["tracking_number"],
              details: packages_availables[index],
              addPackage: addPackage,
              removePackage: deletePackage,
              needCheck: true,
            );
          }),
    ]));
  }
}
