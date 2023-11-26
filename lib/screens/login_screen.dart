// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/screens/home_screen.dart';
import 'package:nurene_app/themes/app_colors.dart';
import '../widgets/button_widget.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../blocs/login/login_bloc.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 20),
            const Text(
              "NURENE\nLifescience",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Username',
              controller: usernameController,
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Password',
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                } else if (state is LoginSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeScreen(user: state.user)));
                  });
                  return const SizedBox.shrink();
                } else {
                  return ButtonWidget(
                    onPressed: () {
                      // Dispatch the LoginButtonPressed event
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginButtonPressed(
                          username: usernameController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    label: 'Login',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}