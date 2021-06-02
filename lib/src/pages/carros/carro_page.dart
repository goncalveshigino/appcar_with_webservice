import 'package:flutter/material.dart';

import 'carros.dart';

class CarroPage extends StatelessWidget {
  CarroPage(this.carro);

  Carro carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Image.network(carro.urlFoto)
    );
  }
}
