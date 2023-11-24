import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/blocs/login/login_bloc.dart';
import 'package:nurene_app/themes/app_colors.dart';
import 'your_bloc_file.dart'; // Import the file where you defined your BLoC

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme : const ColorScheme.light().copyWith(
          background: AppColors.backgroundColor
        )
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginScreen(),
            ),
        '/home': (context) => BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeScreen(),
            ),
      },
    );
  }
}
