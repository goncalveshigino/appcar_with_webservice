
import 'package:http/http.dart' as http;



import 'dart:async';

import 'package:carros/src/pages/carros/carros.dart';
import 'package:carros/src/pages/carros/carros_api.dart';
import 'package:mobx/mobx.dart';




class LoripsumBloc  {

  static String lorim;
   
   final _streamController = StreamController<String>();

    Stream<String> get  stream => _streamController.stream;

    fetch() async {
      
      String s = lorim ?? await LoripSumApi.getLoripsum();

      lorim = s;

      _streamController.add(s);
    }

    void dispose(){
      _streamController.close();
    }
}


class  LoripSumApi {
   
   static Future<String>getLoripsum() async {
      
      var url = 'https://loripsum.net/api';

      print('GET > $url');

      var response = await http.get(url);

      String  text = response.body;

      text = text.replaceAll("<p>", "");
      text = text.replaceAll("</p>", "");

      return text;
   }
}