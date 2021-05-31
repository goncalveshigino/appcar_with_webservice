
import 'package:carros/src/pages/carros/carros_api.dart';
import 'package:carros/src/pages/carros/carros_list_view.dart';
import 'package:carros/src/widget/drawer.dart';
import 'package:flutter/material.dart'; 
import 'dart:core';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carros'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
               Tab(text: "Classicos",), 
               Tab(text: "Esportivos"), 
               Tab(text: "Luxo")
            ],
          ),
        ),

        body: TabBarView(
          children: [
            CarrosListView(TipoCarro.classicos), 
            CarrosListView(TipoCarro.esportivos), 
            CarrosListView(TipoCarro.luxo)
          ],
        ),
        drawer: MeuDrawer(),
      ),
    );
  }
}