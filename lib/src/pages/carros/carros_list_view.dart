import 'package:carros/src/pages/carros/components/carros_page.dart';

import 'package:carros/src/widget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'carros.dart';
import 'carros_bloc.dart';

class CarrosPage extends StatefulWidget {
  CarrosPage(this.tipo);

  String tipo;

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin {
  List<Carro> carros;

  String get tipo => widget.tipo;

  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();

    _loadingCarros();
  }

  void _loadingCarros() {
    _bloc.loadingCarros(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError('Nao foi possivel buscar os carros');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
            onRefresh: _onRefresh, child: CarrosListView(carros));
      },
    );
  }

  Future<void> _onRefresh() {
    print('gdgdgdgdg$tipo');
    return _bloc.loadingCarros(tipo);
  }
}
