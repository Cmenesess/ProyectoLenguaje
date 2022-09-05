// ignore_for_file: always_specify_types, prefer_typing_uninitialized_variables, always_put_required_named_parameters_first, prefer_const_constructors

import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  final int sentPackages;
  final String phone;
  const NumbersWidget({
    required this.sentPackages,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildStatistic(context, phone, 'Telefono'),
            buildDivider(),
            buildStatistic(context, "$sentPackages", 'Paquetes Enviados'),
          ],
        ),
      );
  Widget buildDivider() => VerticalDivider();
  Widget buildStatistic(BuildContext context, String s, String t) {
    return MaterialButton(
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            s,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 3,
          ),
          Text(t)
        ],
      ),
    );
  }
}
