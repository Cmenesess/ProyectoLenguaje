// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(
  BuildContext context, {
  required dynamic images,
  required String numeroRastreo,
  required String posicionActual,
  required String peso,
  required String precio,
  required String fecha,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
          images: images,
          numeroRastreo: numeroRastreo,
          posicionActual: posicionActual,
          peso: peso,
          precio: precio,
          fecha: fecha),
    );

class TextDialogWidget extends StatefulWidget {
  final dynamic images;
  final String numeroRastreo;
  final String fecha;
  final String posicionActual;
  final String peso;
  final String precio;

  const TextDialogWidget({
    Key? key,
    required this.numeroRastreo,
    required this.fecha,
    required this.posicionActual,
    required this.peso,
    required this.precio,
    required this.images,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text("Detalles",
            style: TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 253, 228, 3))),
        content: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Número de rastreo",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Text(widget.numeroRastreo,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 51, 50, 50))),
            Divider(
              color: Color.fromARGB(255, 194, 191, 191),
              height: 15,
              thickness: 1,
              endIndent: 10,
            ),
            Text("Posición actual",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Text(widget.posicionActual,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 51, 50, 50))),
            Divider(
              color: Color.fromARGB(255, 194, 191, 191),
              height: 15,
              thickness: 1,
              endIndent: 10,
            ),
            Text("Peso",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Text(widget.peso,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 51, 50, 50))),
            Divider(
              color: Color.fromARGB(255, 194, 191, 191),
              height: 15,
              thickness: 1,
              endIndent: 10,
            ),
            Text("Precio",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Text('\$${widget.precio}',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 51, 50, 50))),
            Divider(
              color: Color.fromARGB(255, 194, 191, 191),
              height: 15,
              thickness: 1,
              endIndent: 10,
            ),
            Text("Fecha estimada de llegada",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Text(widget.fecha,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 51, 50, 50))),
            Divider(
              color: Color.fromARGB(255, 194, 191, 191),
              height: 15,
              thickness: 1,
              endIndent: 10,
            ),
            Text("Contenido",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 15, 96, 162))),
            Container(
                width: 400, height: 200, child: Gallery(images: widget.images)),
          ]),
        ),
        actions: [
          ElevatedButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
}

class Gallery extends StatefulWidget {
  final dynamic images;
  Gallery({Key? key, this.images}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late bool loading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ImagePage(widget.images[index]['source'])));
          },
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(widget.images[index]['source']),
            fit: BoxFit.cover,
          ),
        );
      },
      itemCount: widget.images.length,
    );
  }
}

class ImagePage extends StatelessWidget {
  final String url;
  const ImagePage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ));
  }
}
