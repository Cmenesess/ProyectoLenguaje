// ignore_for_file: unnecessary_new, unused_field, prefer_const_constructors, always_specify_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sava_mobile/providers/user_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final TextEditingController phoneEditingController =
      new TextEditingController();
  final TextEditingController emailEditingController =
      new TextEditingController();
  final TextEditingController passwordEditingController =
      new TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Por favor ingrese el correo");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor ingrese el correo");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("La contrase??a es requerida para iniciar sesi??n.");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingrese una nueva contrase??a(Min. 6 Caracteres)");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contrase??a",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // address field
    final phoneField = TextFormField(
        autofocus: false,
        controller: phoneEditingController,
        onSaved: (value) {
          phoneEditingController.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp('^09[0-9]{8}');
          if (value!.isEmpty) {
            return ("Deber ingresar un numero valido de Ecuador");
          }
          if (!regex.hasMatch(value)) {
            return ("El formato del numero debe ser con 09");
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Numero Telefono",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Las constrase??as deben coincidir.";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmar contrase??a.",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 12, 108, 203),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            String correo = emailEditingController.text;
            String password = passwordEditingController.text;
            String telefono = phoneEditingController.text;
            String confirmPassword = confirmPasswordEditingController.text;

            if (password != confirmPassword) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Las contrase??as ingresadas no coinciden')));
            }
            if (_formKey.currentState!.validate()) {
              var response =
                  await UserProvider.createUser(telefono, correo, password);

              if (response['status'] == 201) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Se creo su usuario exitosamente')));
                Navigator.popAndPushNamed(context, "login");
              } else if (response['status'] == 400 ||
                  response['status'] == 204) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Ya existe ese usuario con ese correo')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error interno del servidor')));
              }
            }
          },
          child: Text(
            "Registrarse",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 30),
                    emailField,
                    SizedBox(height: 20),
                    phoneField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 40),
                    signUpButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
