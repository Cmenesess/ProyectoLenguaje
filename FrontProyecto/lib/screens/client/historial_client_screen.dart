// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sava_mobile/widgets/history_package.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/history_package_provider.dart';

class HistorialClientScreen extends StatefulWidget {
  const HistorialClientScreen({Key? key}) : super(key: key);

  @override
  State<HistorialClientScreen> createState() => _HistorialClientScreenState();
}

void updateId(int newId) {}

class _HistorialClientScreenState extends State<HistorialClientScreen> {
  String dropValue = 'ASC';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  late SharedPreferences prefs;
  dynamic packages = [];

  void _showDateStartPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2024))
        .then((value) {
      setState(() {
        _startDate = value!;
      });
    });
  }

  void _showDateEndPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2024))
        .then((value) {
      setState(() {
        _endDate = value!;
      });
    });
  }

  void getOrderPackages(String order) {
    if (order == "ASC") {
      Future.delayed(Duration.zero, () async {
        prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        dynamic response =
            await HistoryPackageProvider.getHistoryPackagesByASCOrder(token!);
        packages = response;
        setState(() {});
      });
    } else {
      Future.delayed(Duration.zero, () async {
        prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        dynamic response =
            await HistoryPackageProvider.getHistoryPackagesByDESCOrder(token!);
        packages = response;
        setState(() {});
      });
    }
  }

  void getBetweenPackages(String start, String end) {
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response =
          await HistoryPackageProvider.getHistoryPackagesBetweenDates(token!, start, end);
      packages = response;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      dynamic response =
          await HistoryPackageProvider.getHistoryPackages(token!);
      packages = response;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Historial",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                    value: dropValue,
                    icon: Icon(
                      Icons.sort_rounded,
                      color: Colors.white,
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropValue = newValue!;
                        getOrderPackages(dropValue);
                      });
                    },
                    items: ["ASC", "DESC"].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.indigo[900], boxShadow: [
            BoxShadow(
              offset: Offset(3, 0),
              spreadRadius: -3,
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 1),
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: _showDateStartPicker,
                child: Center(
                  child: Text(
                    "Inicio",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: _showDateEndPicker,
                child: Center(
                  child: Text(
                    "Fin",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  getBetweenPackages(_startDate.toString(), _endDate.toString());
                },
                child: Center(
                  child: Text(
                    "Aplicar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: packages.length,
            itemBuilder: (context, index) {
              return HistoryPackageWidget(packages[index]['sava_code'],
                  packages[index]['arrival_date_destiny']);
            })
      ],
    ));
  }
}
