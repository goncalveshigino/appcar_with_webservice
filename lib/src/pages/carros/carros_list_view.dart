import 'dart:async';

import 'package:carros/src/pages/carros/carros_api.dart';
import 'package:carros/src/util/nav.dart';
import 'package:carros/src/widget/const.dart';
import 'package:carros/src/widget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'carro_page.dart';
import 'carros.dart';
import 'carros_model.dart';


class CarrosListView extends StatefulWidget {
  CarrosListView(this.tipo);

  String tipo;

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin {
  List<Carro> carros;

  String get tipo => widget.tipo;

  final _model = CarrosModel();

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();

   _loadingCarros();
  }

 void  _loadingCarros(){
    _model.loadingCarros(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer( 
      builder: (_) {

        
        List<Carro> carros = _model.carros;

        if (_model.error != null) {
          return TextError('Erro nao foi possivel buscar os carros\n\nClique aqui para tentar novamente',
          onPressed: _loadingCarros);
        }

        if (carros == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

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
