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
          buildEspaciador(20),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          buildEspaciador(24),
          buildName(user),
          buildEspaciador(16),
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
