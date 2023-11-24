// lib/blocs/login/login_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        // Simulate an authentication process
        await Future.delayed(const Duration(seconds: 2));

        // Replace this with your actual authentication logic
        if (event.username == 'demo' && event.password == 'password') {
          yield const LoginSuccess(message: 'Login successful');
        } else {
          throw Exception('Invalid credentials');
        }
      } catch (error) {
        yield const LoginFailure(error: 'Authentication failed');
      }
    }
  }
}
