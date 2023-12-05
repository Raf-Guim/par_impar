import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:par_impar/aposta.dart';
import 'package:par_impar/cadastro.dart';
import 'package:par_impar/lista.dart';
import 'package:par_impar/resultado.dart';
import 'package:http/http.dart' as http;

class TelaPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  var itens = [];

  testeFun(itens) async {
    await http
        .get(Uri.https('par-impar.glitch.me', '/jogadores'))
        .then((value) => {
              itens.clear(),
              jsonDecode(value.body)['jogadores'].forEach((element) {
                itens.add({
                  'username': element['username'].toString(),
                  'valor': int.parse(element['pontos'].toString())
                });
              })
            });
    print(itens);
  }

  apostaFunc(aposta, numero, parImpar) async {
    await http.post(Uri.https('par-impar.glitch.me', '/aposta'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'username': username,
          'valor': aposta,
          'numero': numero,
          'parimpar': parImpar
        }));
  }

  var exibirTela = 1;
  var aposta;
  var lista;
  var cadastro;
  var resultado = Resultado();
  var username;
  var valor;
  var parImpar;
  var numero;
  var data;
  var body;

  @override
  void initState() {
    exibirTela = 1;

    setState(() {
      testeFun(itens);
    });

    lista = Lista(
      callback: () {
        setState(() {
          testeFun(itens);
        });
      },
      itens: itens,
    );

    aposta = Aposta(callback: (aposta, numero, parImpar) {
      setState(() {
        testeFun(itens);
        apostaFunc(aposta, numero, parImpar);
        this.aposta = aposta;
        this.numero = numero;
        this.parImpar = parImpar;
        exibirTela = 3;
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
        itens.add({'username': username, 'valor': 1000});
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
