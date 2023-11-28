import 'package:flutter/material.dart';
import 'package:par_impar/tela_principal.dart';
import 'package:http/http.dart' as http;

// POST - https://par-impar.glitch.me/novo
// BODY - {'username' : 'edson'}

void main() {
  runApp(_Inicio());
}

class _Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Par ou Impar",
      home: Scaffold(
        appBar: AppBar(title: const Text('Par ou Impar')),
        body: TelaPrincipal(),
      ),
    );
  }
}
