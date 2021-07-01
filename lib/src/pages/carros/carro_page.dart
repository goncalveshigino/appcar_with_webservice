import 'package:carros/src/pages/carros/loripsum_api.dart';
import 'package:flutter/material.dart';

import 'carros.dart';

class CarroPage extends StatefulWidget {


  CarroPage(this.carro);

  Carro carro;

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {

 final _loripsumApiBloc = LoripsumBloc(); 


  @override
  void initState() { 
    super.initState();
    
   _loripsumApiBloc.fetch();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(left: 9),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          SizedBox(
            height: 20,
          ),
          _bloco2()
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.carro.nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.carro.tipo,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red, size: 30),
              onPressed: _onClickFavorite,
            ),
            IconButton(
              icon: Icon(Icons.share, size: 30),
              onPressed: _onClickShared,
            )
          ],
        )
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar !!!");
        break;
      case "Deletar":
        print("Deletar !!!");
        break;
      case "Share":
        print("Share !!!");
        break;
    }
  }

  void _onClickFavorite() {}

  void _onClickShared() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.carro.descricao,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 12,
        ),
        StreamBuilder(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Text(snapshot.data,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300));
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
