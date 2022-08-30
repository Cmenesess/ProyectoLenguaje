// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, always_specify_types, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sava_mobile/models/dosage_model.dart';
import 'package:sava_mobile/providers/warehouse_package_provider.dart';
import 'package:sava_mobile/screens/ProfileScreen.dart';
import 'package:sava_mobile/screens/client/sava_packages_client_screen.dart';
import 'package:sava_mobile/widgets/warehouse_package_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/create_cell.dart';
import '../screens.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({Key? key}) : super(key: key);

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  final GlobalKey<ProfileScreenState> _MyWidgetState =
      GlobalKey<ProfileScreenState>();

  final screens = [
    PackagesClientScreen(),
    SavaPackagesClientScreen(),
    HistorialClientScreen()
  ];

  //Shared Preferences
  late SharedPreferences prefs;

  @override
  void initState() {
    screens.add(ProfileScreen(
      key: _MyWidgetState,
    ));

    super.initState();
  }

  final appBar = AppBar(
    elevation: 10,
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 12, 108, 203),
    title: const Text(
      "SavaExpress",
      style: TextStyle(color: Color.fromARGB(255, 225, 228, 230), fontSize: 30),
    ),
    leading: Container(
      child: null,
    ),
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () async {
            await SystemChannels.platform
                .invokeMethod('SystemNavigator.pop', true);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.logout_rounded),
          ),
        ),
      )
    ],
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) async {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                label: "Paquetería",
                icon: ImageIcon(AssetImage("assets/entrega-rapida.png"))),
            BottomNavigationBarItem(
                label: "Envíos",
                icon: ImageIcon(AssetImage("assets/avion.png"))),
            BottomNavigationBarItem(
                label: "Historial", icon: Icon(Icons.history)),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            )
          ]),
    );
  }
}
