import 'dart:async';

import 'package:carros/src/pages/carros/carros.dart';
import 'package:carros/src/pages/carros/carros_api.dart';

class CarrosBloc {

  final _streamController = StreamController<List<Carro>>();
   
  Stream<List<Carro>> get carros => _streamController.stream;

   loadingCarros(String tipo) async {
    
    List<Carro> carros = await CarrosApi.getCarros( tipo);

    _streamController.add(carros);
  }


  void dispose() {
  
    _streamController.close();
  }
}