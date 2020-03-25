import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacto"),
      ),
      body: Container(
        margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Acerca de apuntes:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Esta app sirve para crear recordatorios y apuntes.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Desarrollada por Diego Cejudo Solis.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  sendEmail();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "¡Envíanos tus comentarios!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void sendEmail() async {
  final Email email = Email(
    body: 'Email body',
    recipients: ['is705152@iteso.mx'],
    subject: 'Comentarios sobre app recordatorios',
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}
