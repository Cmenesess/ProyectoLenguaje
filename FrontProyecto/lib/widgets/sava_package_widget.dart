// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sava_mobile/widgets/sava_package_detail_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SavaPackageWidget extends StatefulWidget {
  final dynamic details;
  SavaPackageWidget({Key? key, this.details}) : super(key: key);

  @override
  State<SavaPackageWidget> createState() => _SavaPackageWidgetState();
}

class _SavaPackageWidgetState extends State<SavaPackageWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _value == true ? Colors.indigo[900] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(15),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Paquete",
                        style:
                            TextStyle(fontSize: 25, color: Colors.indigo[900]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  this.widget.details['sava_code'],
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: StepProgressIndicator(
                  totalSteps: 10,
                  currentStep: 2,
                  selectedColor: Color.fromARGB(255, 254, 229, 5),
                  unselectedColor: Color.fromARGB(255, 190, 189, 189),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      this.widget.details['status'],
                      style: TextStyle(fontSize: 20, color: Colors.indigo[900]),
                    )),
                    IconButton(
                      icon: Icon(Icons.keyboard_double_arrow_right),
                      color: Color.fromARGB(255, 15, 96, 162),
                      onPressed: () async {
                        dynamic images = [];
                        this.widget.details['WarehousePackages'].forEach((v) {
                          images.addAll(v['Images']);
                        });
                        await showTextDialog(context,
                            images: images,
                            numeroRastreo: widget.details['sava_code'],
                            posicionActual: 'Viajando',
                            peso: "${widget.details['weight']} lb",
                            precio: "${widget.details['price']}",
                            fecha: widget.details['arrival_date_destiny'] ??
                                "Sin fecha de llegada",
                            fecha_salida: widget.details['departureDate'] ??
                                "Sin fecha de salida");
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
