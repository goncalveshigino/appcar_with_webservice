import 'dart:async';

import 'package:carros/src/pages/api_login/api_response.dart';
import 'package:carros/src/pages/api_login/login_api.dart';
import 'package:carros/src/pages/api_login/login_bloc.dart';
import 'package:carros/src/pages/home/home_page.dart';
import 'package:carros/src/pages/user/user.dart';
import 'package:carros/src/util/alert.dart';
import 'package:carros/src/util/nav.dart';
import 'package:carros/src/widget/appButton.dart';
import 'package:carros/src/widget/appTextForm.dart';
import 'package:carros/src/widget/const.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

 

  final _bloc = LoginBloc();

  final _tLogin = TextEditingController();

  final _tPassword = TextEditingController();

  final _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();

    // Mostrar dados do ultimo usuario logado
    Future<User> future = User.get();
    future.then((User user) {
      if (user != null) push(context, HomePage(), replace: true);
      // setState(() {
      //   _tLogin.text = user.login;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(PRIMARY_COLOR),
      appBar: AppBar(
        backgroundColor: Color(0xff615AAB),
        title: const Text('Carros'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 8,
          child: ListView(
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              AppText('Login', 'Digite seu login',
                  controller: _tLogin,
                  validator: _validateLogin,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  nextFocus: _focusPassword),
              const SizedBox(height: 16),
              AppText(
                'Password',
                'Digite sua password',
                controller: _tPassword,
                password: true,
                validator: _validatePassword,
                keyboardType: TextInputType.number,
                focusNode: _focusPassword,
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<bool>(
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  return AppButton(
                    'Login',
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data ?? false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String password = _tPassword.text;

    print("login: $login, password: $password");

    ApiResponse response = await _bloc.login(login, password);

    if (response.ok) {
      User user = response.result;

      print('>>> $user');

      push(context, HomePage());
    } else {
      alert(context, response.msg);
    }
  }

  String _validateLogin(String value) {
    if (value.isEmpty) return 'Digite o login';
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Digite a password';
    }
    if (value.length < 3) {
      return 'A senha precisa ter pelo menus 3 números';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
