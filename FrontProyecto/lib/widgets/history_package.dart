import 'package:flutter/material.dart';

class HistoryPackageWidget extends StatelessWidget {
  final String packageNum;
  final dynamic arrival;

  HistoryPackageWidget(this.packageNum, this.arrival);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(right: 20, left: 20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paquete " + packageNum.toString(),
            style: TextStyle(color: Colors.indigo[900], fontSize: 27),
          ),
          Row(
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Center(
                    child: Text(
                      "Entregado",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.yellow[800],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Center(
                    child: Text(
                      arrival,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
