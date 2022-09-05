import 'package:sava_mobile/widgets/sava_package_detail_widget.dart';

class User {
  final String imagePath;
  final String name;
  final String email;
  final int paquetesEnviados;

  const User(
      {required this.imagePath,
      required this.name,
      required this.email,
      required this.paquetesEnviados});
}
