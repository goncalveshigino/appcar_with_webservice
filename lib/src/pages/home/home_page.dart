import 'package:carros/src/pages/carros/carros_api.dart';
import 'package:carros/src/pages/carros/carros_list_view.dart';
import 'package:carros/src/util/prefs.dart';
import 'package:carros/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);

    int tabIdx = await Prefs.getInt("tabIdx");
    _tabController.index = tabIdx;

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Classicos",
            ),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo)
        ],
      ),
      drawer: MeuDrawer(),
    );
  }
}
