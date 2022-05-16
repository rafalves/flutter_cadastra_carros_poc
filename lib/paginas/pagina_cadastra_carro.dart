import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cadastro_carros/banco/firebase_db.dart';
import 'package:flutter_cadastro_carros/funcoes/imagens_funcoes.dart';

class PaginaCadastroCarro extends StatefulWidget {
  const PaginaCadastroCarro({Key? key}) : super(key: key);

  @override
  State<PaginaCadastroCarro> createState() => _PaginaCadastroCarroState();
}

class _PaginaCadastroCarroState extends State<PaginaCadastroCarro> {
  final TextEditingController marcaCarro = TextEditingController();
  final TextEditingController modeloCarro = TextEditingController();
  final TextEditingController anoCarro = TextEditingController();

  bool contemImagem = false;
  String pickerText = '';
  File? imagemCarro;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    marcaCarro.text = '';
    modeloCarro.text = '';
    anoCarro.text = '';
  }

  @override
  void dispose() {
    marcaCarro.dispose();
    modeloCarro.dispose();
    anoCarro.dispose();
    super.dispose();
  }

  limpaDados() {
    setState(() {
      marcaCarro.text = '';
      modeloCarro.text = '';
      anoCarro.text = '';
      contemImagem = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Carros',
        ),
        actions: [
          IconButton(
            onPressed: limpaDados,
            icon: const Icon(Icons.refresh),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: marcaCarro,
                  decoration: const InputDecoration(
                      hintText: 'Digite a marca do carro'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite a marca de um carro';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: modeloCarro,
                  decoration: const InputDecoration(
                      hintText: 'Digite o modelo do carro'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o modelo de um carro';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: anoCarro,
                  decoration:
                      const InputDecoration(hintText: 'Digite o ano do carro'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o ano de um carro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('imagem'),
                    IconButton(
                      onPressed: () async {
                        final imagem = await selecionaImagem();
                        if (imagem != null) {
                          setState(() {
                            imagemCarro = File(imagem.path);
                            contemImagem = true;
                            pickerText = '';
                          });
                        } else {
                          setState(() {
                            pickerText = 'erro ao selecionar imagem';
                          });
                        }
                      },
                      icon: const Icon(Icons.upload),
                    ),
                  ],
                ),
                contemImagem
                    ? ListTile(
                        leading: SizedBox(
                          width: 60,
                          height: 40,
                          child: Image.file(
                            imagemCarro!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text('Carro'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              contemImagem = !contemImagem;
                            });
                          },
                        ),
                      )
                    : SizedBox(
                        height: 56,
                        child: Text(pickerText),
                      ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: contemImagem
                        ? () async {
                            if (formKey.currentState!.validate()) {
                              String id = const Uuid().v4();
                              await FirebaseDB().cadastraCarro(marcaCarro.text,
                                  modeloCarro.text, anoCarro.text, id);
                              await FirebaseDB()
                                  .cadastraImagem(imagemCarro!, id);
                            }
                            limpaDados();
                          }
                        : null,
                    child: const Text('Cadastrar Carro'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
