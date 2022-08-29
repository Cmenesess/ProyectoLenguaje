// ignore_for_file: prefer_const_constructors, always_specify_types, use_build_context_synchronously, unused_local_variable

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          child: packages.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow)),
                      onPressed: () async {
                        var response =
                            await WarehousePackageProvider.createSavaPackages(
                                packages);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Paquete creado correctamente')));
                        Navigator.popAndPushNamed(context, "home_client");
                      },
                      child: Text(
                        "Enviar Paquetes (${packages.length})",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                )
              : null),
      Text(
        "Selecciona los paquetes a enviar",
        style:
            TextStyle(fontSize: 30, color: Color.fromARGB(255, 22, 102, 168)),
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
