import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cadastro_carros/banco/firebase_db.dart';
import 'package:flutter_cadastro_carros/modelos/carro.dart';

class WidgetCarro extends StatelessWidget {
  final Carro carro;
  const WidgetCarro({
    required this.carro,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Reference referencia = FirebaseDB().pegaImagem(carro.id);

    return Card(
      child: Column(
        children: [
          FutureBuilder<Uint8List?>(
            future: referencia.getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Image.memory(
                      data,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return const Image(
                      image: AssetImage('assets/no-image.jpg'),
                      alignment: Alignment.center,
                      height: 80,
                      width: 150,
                      fit: BoxFit.fill,
                    );
                  }
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Chip(label: Text(carro.marca)),
              Chip(label: Text(carro.modelo)),
              Chip(
                label: Text(carro.ano.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
