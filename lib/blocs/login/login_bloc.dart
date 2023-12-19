// lib/blocs/login/login_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nurene_app/services/api_services.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../models/user_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  LoginBloc(this.apiService) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final loggedInUser = await apiService.login(
            username: event.username, password: event.password);
        UserModel user = UserModel(username: loggedInUser['username']);
        yield LoginSuccess(message: "message", user: user);
      } catch (error) {
        yield const LoginFailure(error: "Authentication failed");
      }
    }
  }
}
