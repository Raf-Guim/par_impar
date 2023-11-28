import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cadastro extends StatefulWidget {
  Function callback = () => {};

  // ignore: use_key_in_widget_constructors
  Cadastro({required this.callback});

  @override
  State<StatefulWidget> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: username,
            decoration: const InputDecoration(
              label: Text('Nome do Usuario'),
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                widget.callback(username.text);
              },
              child: const Text('Cadastrar!'))
        ],
      ),
    );
  }
}
