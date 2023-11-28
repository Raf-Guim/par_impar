import 'package:flutter/material.dart';

class Aposta extends StatefulWidget {
  var username;
  Function callback = () => {};

  Aposta({required this.callback});

  @override
  State<StatefulWidget> createState() => _ApostaState();
}

class _ApostaState extends State<Aposta> {
  var numero = 1.0;
  var aposta = 10.0;
  var par_impar = 0;
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text('username: ${widget.username}'), // Text(
          Text('Aposta: ${aposta.toInt()}'),
          Slider(
              value: aposta,
              min: 10,
              max: 1000,
              divisions: 10,
              onChanged: (valor) {
                setState(() {
                  aposta = valor;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                  value: 1,
                  groupValue: par_impar,
                  onChanged: (valor) {
                    setState(() {
                      if (valor != null) par_impar = valor;
                    });
                  }),
              const Text('Impar'),
              Radio(
                  value: 2,
                  groupValue: par_impar,
                  onChanged: (valor) {
                    setState(() {
                      if (valor != null) par_impar = valor;
                    });
                  }),
              const Text('Par')
            ],
          ),
          Text('Número: ${numero.toInt()}'),
          Slider(
              value: numero,
              min: 1,
              max: 5,
              onChanged: (valor) {
                setState(() {
                  numero = valor;
                });
              }),
          ElevatedButton(
              onPressed: () {
                widget.callback(aposta, numero, par_impar);
              },
              child: const Text('Apostar!'))
        ],
      ),
    );
  }
}
