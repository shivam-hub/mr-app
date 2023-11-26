// lib/blocs/login/login_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../models/user_model.dart';

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
        if (event.username == '1' && event.password == '1') {
          final user = UserModel(
            username: event.username, /* Add other user data */
          );
          yield LoginSuccess(user : user ,message: 'Login successful');
        } else {
          throw Exception('Invalid credentials');
        }
      } catch (error) {
        yield const LoginFailure(error: 'Authentication failed');
      }
    }
  }
}
