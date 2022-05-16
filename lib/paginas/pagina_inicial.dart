import 'package:flutter/material.dart';
import 'package:flutter_cadastro_carros/paginas/pagina_cadastra_carro.dart';
import 'package:flutter_cadastro_carros/paginas/pagina_ver_veiculos.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App veículos - Firebase',
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const PaginaCadastroCarro()))),
            child: const Text('Cadastrar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const PaginaVerVeiculos()))),
            child: const Text('Ver carros'),
          ),
        ],
      )),
    );
  }
}
