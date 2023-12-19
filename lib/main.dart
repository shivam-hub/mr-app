import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/services/api_services.dart';
import 'blocs/login/login_bloc.dart';
import 'screens/login_screen.dart';
import 'themes/app_colors.dart';
import 'services/locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light()
              .copyWith(background: AppColors.backgroundColor)),
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginBloc(locator<ApiService>()),
              child: LoginScreen(),
            ),
        // '/home': (context) => BlocProvider(
        //       create: (context) => HomeBloc(),
        //       child: HomeScreen(),
        //     ),
      },
    );
  }
}
