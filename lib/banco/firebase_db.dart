import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cadastro_carros/modelos/carro.dart';

class FirebaseDB {
  final CollectionReference cadastro =
      FirebaseFirestore.instance.collection('cadastro');
  final Stream<QuerySnapshot> dadosDoFirebase =
      FirebaseFirestore.instance.collection('cadastro').snapshots();

  Future<DocumentReference> cadastraCarro(
      String marca, String modelo, String ano, String id) async {
    return cadastro.add({
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
    });
  }

  Future<UploadTask> cadastraImagem(File file, String id) async {
    try {
      String ref = 'carros/images/$id';
      return FirebaseStorage.instance.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  List<Carro> pegaCarros(AsyncSnapshot<QuerySnapshot> snapshot) {
    final List<Carro> carros = [];
    if (snapshot.hasData) {
      for (DocumentSnapshot documento in snapshot.data!.docs) {
        carros.add(
          Carro(
            id: documento['id'],
            marca: documento['marca'],
            modelo: documento['modelo'],
            ano: documento['ano'],
          ),
        );
      }
    }
    return carros;
  }

  Reference pegaImagem(String id) {
    return FirebaseStorage.instance.ref('/carros/images/').child(id);
  }
}
