import 'dart:async';

import 'package:carros/src/pages/carros/simple_bloc.dart';
import 'package:carros/src/pages/user/user.dart';

import 'api_response.dart';
import 'login_api.dart';

class LoginBloc extends SimpleBloc<bool> {



  Future<ApiResponse<User>> login(String login, String password) async {
     
     add(true);

    ApiResponse response = await LoginApi.login(login, password);
     
      add(false);

    return response;
  }

}
