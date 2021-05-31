import 'package:carros/src/pages/login/login_page.dart';
import 'package:carros/src/util/nav.dart';
import 'package:flutter/material.dart'; 

class MeuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Higino Luis"),
              accountEmail: Text("higino@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/dog1.png'),
              ),
            ),
             ListTile(
               leading: Icon(Icons.star),
               title: Text('Favoritos'),
               subtitle: Text("mais Informacoes..."), 
               trailing: Icon(Icons.arrow_forward),
               onTap: (){
                 print("Item 1");
                 Navigator.pop(context);
               },
             ), 

              ListTile(
               leading: Icon(Icons.help),
               title: Text('Ajuda'),
               subtitle: Text("mais Informacoes..."), 
               trailing: Icon(Icons.arrow_forward),
               onTap: (){
                 print("Item 1");
                 Navigator.pop(context);
               },
             ), 

              ListTile(
               leading: Icon(Icons.exit_to_app),
               title: Text('Logout'),
               trailing: Icon(Icons.arrow_forward),
               onTap: () => _onClickLogout(context),
             )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }

  
}