import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildStatistic(context, '98%', 'Paquetes '),
            buildDivider(),
            buildStatistic(context, '8', 'Paquetes '),
            buildDivider(),
            buildStatistic(context, '100%', 'Satisfacción'),
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
