import 'package:flutter/material.dart';
import 'package:sava_mobile/utils/user_preferences.dart';
import 'package:sava_mobile/utils/numbers_widget.dart';
import 'package:sava_mobile/screens/ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 120,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
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
                "Perfil",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          buildEspaciador(40),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          buildEspaciador(32),
          buildName(user),
          buildEspaciador(32),
          NumbersWidget(),
        ],
      ),
    );
  }
}

Widget buildEspaciador(double espacio) => SizedBox(
      height: espacio,
    );
Widget buildName(user) {
  return Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      buildEspaciador(4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );
}
