import 'dart:async';

import 'package:carros/src/pages/carros/carros_api.dart';
import 'package:carros/src/util/nav.dart';
import 'package:carros/src/widget/const.dart';
import 'package:flutter/material.dart';

import 'carro_page.dart';
import 'carros.dart';

class CarrosListView extends StatefulWidget {
  CarrosListView(this.tipo);

  String tipo;

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin {
  List<Carro> carros;

  final _streamController = StreamController<List<Carro>>();

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();

    _loadingCarros();
  }

  _loadingCarros() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);

    _streamController.add(carros);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child:
                Text('Erro ao carregar', style: TextStyle(color: Colors.red)),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
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
                          onPressed: () => _onClickDetails(c)),
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

  _onClickDetails(Carro c) {
    push(context, CarroPage(c));
  }
}
