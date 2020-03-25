import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Details extends StatefulWidget {
  final String receivedDescripcion;
  final String receivedMateria;
  final String receivedImageURL;
  const Details({
    Key key,
    @required this.receivedDescripcion,
    @required this.receivedMateria,
    @required this.receivedImageURL,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles de apunte")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                height: 220,
                child: ClipRect(
                  child: PhotoView.customChild(
                    child: Container(
                      child: Image.network(
                        widget.receivedImageURL,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.receivedMateria,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.receivedDescripcion,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
