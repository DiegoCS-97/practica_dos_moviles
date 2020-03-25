import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_dos/models/apunte.dart';
import 'package:path/path.dart' as Path;

part 'apuntes_event.dart';
part 'apuntes_state.dart';

class ApuntesBloc extends Bloc<ApuntesEvent, ApuntesState> {
  final Firestore _firestoreInstance = Firestore.instance;
  List<Apunte> _apuntesList;
  List<DocumentSnapshot> _documentsList;
  List<Apunte> get getApuntesList => _apuntesList;
  File choosenImage;
  String imageURL;

  @override
  ApuntesState get initialState => ApuntesInitial();

  @override
  Stream<ApuntesState> mapEventToState(
    ApuntesEvent event,
  ) async* {
    if (event is GetDataEvent) {
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    } else if (event is SaveDataEvent) {
      String url = await _uploadFile();
      bool saved = await _saveApunte(
        event.materia,
        event.descripcion,
        url,
      );
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        );
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _apuntesList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    } else if (event is ChooseImageEvent) {
      await _chooseImage();
      yield ChoosenImage(image: choosenImage);
    }
  }

  Future<bool> _getData() async {
    try {
      var apuntes =
          await _firestoreInstance.collection("apuntes").getDocuments();
      _apuntesList = apuntes.documents
          .map(
            (apunte) => Apunte(
              materia: apunte["materia"],
              descripcion: apunte["descripcion"],
              imageUrl: apunte["imagen"],
            ),
          )
          .toList();
      _documentsList = apuntes.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveApunte(
    String materia,
    String descripcion,
    String imageUrl,
  ) async {
    try {
      await _firestoreInstance.collection("apuntes").document().setData({
        "materia": materia,
        "descripcion": descripcion,
        "imagen": imageUrl,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future _chooseImage() async {
    await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    ).then((image) {
        choosenImage = image;
      },
    );
  }

  Future _uploadFile() async {
    String filePath = choosenImage.path;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("apuntes/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(choosenImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      print("Link>>>>> $imageUrl");
    });

    return reference.getDownloadURL();
  }

  static void dispatch(RemoveDataEvent removeDataEvent) {}
}
