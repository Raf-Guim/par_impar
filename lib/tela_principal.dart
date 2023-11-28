import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:par_impar/aposta.dart';
import 'package:par_impar/cadastro.dart';
import 'package:par_impar/lista.dart';
import 'package:par_impar/resultado.dart';
import 'package:http/http.dart' as http;

Function testeFun = () async {
  var itens = await http
      .get(Uri.https('par-impar.glitch.me', '/jogadores'))
      .then((value) => {print(jsonDecode(value.body)['jogadores'])});
  return itens;
};

class TelaPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  var itens = [
    {'username': 'edson', 'valor': 100},
    {'username': 'joao', 'valor': 300}
  ];
  var itens_2 = testeFun();

  var exibirTela = 1;
  var aposta;
  var lista;
  var cadastro;
  var resultado = Resultado();
  var username;
  var data;
  var body;

  @override
  void initState() {
    exibirTela = 1;
    lista = Lista(
      callback: () {},
      itens: itens,
    );
    aposta = Aposta(callback: (aposta, numero, par_impar) {
      setState(() {
        // itens.add({'username': username, 'valor': aposta});
      });
    });

    cadastro = Cadastro(callback: (username) {
      data = {'username': username};

      body = json.encode(data);
      http.post(Uri.https('par-impar.glitch.me', '/novo'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: body);
      setState(() {
        this.username = username;
        aposta.username = username;
        exibirTela = 2;
      });
    });
    super.initState();
  }

  Widget selecionaTela() {
    if (exibirTela == 1) {
      return cadastro;
    } else if (exibirTela == 2) {
      return aposta;
    } else if (exibirTela == 3) {
      return lista;
    } else {
      return resultado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return selecionaTela();
  }
}
