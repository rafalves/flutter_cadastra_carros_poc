import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cadastro_carros/banco/firebase_db.dart';
import 'package:flutter_cadastro_carros/componentes/widget_card.dart';

class PaginaVerVeiculos extends StatefulWidget {
  const PaginaVerVeiculos({Key? key}) : super(key: key);

  @override
  State<PaginaVerVeiculos> createState() => _PaginaVerVeiculosState();
}

class _PaginaVerVeiculosState extends State<PaginaVerVeiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros Cadastrados'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseDB().dadosDoFirebase,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final listaCarros = FirebaseDB().pegaCarros(snapshot);
                return SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: listaCarros.length,
                    itemBuilder: (context, index) {
                      return WidgetCarro(
                        carro: listaCarros[index],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
