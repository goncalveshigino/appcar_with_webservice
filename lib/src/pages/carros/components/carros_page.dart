import 'package:carros/src/pages/carros/carro_page.dart';
import 'package:carros/src/util/nav.dart';
import 'package:carros/src/widget/const.dart';
import 'package:flutter/material.dart';

import '../carros.dart'; 

class CarrosListView extends StatelessWidget {

  List<Carro> carros;

  CarrosListView(this.carros);
 

  @override
  Widget build(BuildContext context) {
 
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    c.urlFoto ??
                        'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Ferrari_250_GTO.png',
                    width: 250,
                  ),
                  Text(
                    c.nome,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Descricao...',
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBar(
                    children: [
                      TextButton(
                          child: const Text(
                            'DETAILS',
                            style: TextStyle(color: Color(PRIMARY_COLOR)),
                          ),
                          onPressed: () => _onClickDetails(context, c)),
                      TextButton(
                          child: const Text('SHARE',
                              style: TextStyle(color: Color(PRIMARY_COLOR))),
                          onPressed: () {})
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickDetails(context, c) {
    push(context, CarroPage(c));
  }
}