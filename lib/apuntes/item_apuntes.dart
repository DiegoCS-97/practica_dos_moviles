import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

import 'details_apuntes.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {
  ApuntesBloc _apBloc;

  @override
  Widget build(BuildContext context) {
    _apBloc = BlocProvider.of<ApuntesBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Details(
              receivedMateria: widget.materia,
              receivedDescripcion: widget.descripcion,
              receivedImageURL: widget.imageUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Borrar apunte"),
                        content: Text("¿Seguro que quiere borrar?"),
                        actions: <Widget>[
                          MaterialButton(
                            child: Text("Cancerlar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          MaterialButton(
                            child: Text("Borrar"),
                            onPressed: () {
                              _apBloc.add(
                                RemoveDataEvent(index: widget.index),
                              );

                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            Image.network(
              widget.imageUrl ?? "https://via.placeholder.com/150",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(
                "${widget.materia}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text("${widget.descripcion}"),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
