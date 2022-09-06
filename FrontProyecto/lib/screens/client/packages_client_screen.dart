// ignore_for_file: prefer_const_constructors, always_specify_types, use_build_context_synchronously, unused_local_variable,prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields
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
  bool _isLoading = false;

  void addPackage(String newId, double addPrice) {
    setState(() {
      packages.add(newId);
      price += addPrice;
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
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response =
          await WarehousePackageProvider.getWarehousePackages(token!);
      packages_availables = response;
      setState(() {
        _isLoading = false;
      });
    });
  }

  void createSava() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Confirme'),
            content: const Text(
                'Desea enviar todos esos paquetes seleccionados a Ecuador?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    var response =
                        await WarehousePackageProvider.createSavaPackages(
                            packages);
                    String sava_code = response['sava_code'];
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Creado paquete sava con codigo $sava_code')));
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
            "Bodega",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      if (packages_availables.length > 0)
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.indigo[900], boxShadow: [
            BoxShadow(
              offset: Offset(3, 0),
              spreadRadius: -3,
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 1),
            )
          ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Enviar a Ecuador",
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      _isLoading
          ? CircularProgressIndicator()
          : packages_availables.length > 0
              ? Container(
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow)),
                        onPressed: () async {
                          if (packages.length > 0) {
                            createSava();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        'Debe seleccionar al menos un paquete')));
                          }
                        },
                        child: Text(
                          "Realizar envio (${packages.length})",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: SizedBox(
                      width: 300,
                      child: Text(
                        "No hay paquetes para enviar",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      )),
                ),
      ListView.builder(
          padding: EdgeInsets.zero,
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
