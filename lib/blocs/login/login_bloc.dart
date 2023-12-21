// lib/blocs/login/login_bloc.dart

import 'dart:async';
import 'login_event.dart';
import 'login_state.dart';
import 'package:bloc/bloc.dart';
import '../../models/user_model.dart';
import '../../services/api_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  LoginBloc(this.apiService) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        await apiService.login(
            username: event.username, password: event.password);
        final userDetails = await apiService.getUser();
        yield LoginSuccess(message: "message", user: UserModel.fromJson(userDetails));
      } catch (error) {
        yield const LoginFailure(error: "Authentication failed");
      }
    }
  }
}
