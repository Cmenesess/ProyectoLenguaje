// ignore_for_file: always_specify_types, prefer_const_declarations, prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sava_mobile/utils/user_preferences.dart';
import 'package:sava_mobile/utils/numbers_widget.dart';
import 'package:sava_mobile/screens/ProfileWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  dynamic information;
  String? token;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(milliseconds: 500), (() async {
      prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      dynamic response = await UserProvider.infoClient(token);
      information = response;
      setState(() {
        _isLoading = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                buildEspaciador(20),
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () async {},
                ),
                Column(children: [
                  buildEspaciador(24),
                  buildName(information['username']),
                  buildEspaciador(16),
                  NumbersWidget(
                    sentPackages: information['sentPackages'],
                    phone: information['phone'],
                  ),
                  buildEspaciador(50),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xff2c2c2c),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Cerrar Sesión",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ]),
                    ),
                    onTap: () => {},
                  )
                ]),
              ],
            ),
    );
  }
}

Widget buildEspaciador(double espacio) => SizedBox(
      height: espacio,
    );
Widget buildName(email) {
  return Column(
    children: [
      Text(
        email,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ],
  );
}
