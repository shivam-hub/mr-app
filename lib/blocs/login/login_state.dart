// lib/blocs/login/login_state.dart

import 'package:equatable/equatable.dart';
import 'package:nurene_app/models/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  final String message;

  const LoginSuccess({required this.message, required this.user});

  @override
  List<Object?> get props => [message, user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
