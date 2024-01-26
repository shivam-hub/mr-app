import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/blocs/home/home_bloc.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/login/login_bloc.dart';
import 'models/user_model.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'themes/app_colors.dart';
import 'services/locator.dart';


Future main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
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
        '/home': (context) => BlocProvider(
              create: (context) => HomeScreenBloc(locator<ApiService>()),
              child: FutureBuilder<String?>(
                future: SharedPreferences.getInstance()
                    .then((pref) => pref.getString('userDetails')),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final user = snapshot.data;
                    if (user != null) {
                      return HomeScreen(
                          user: UserModel.fromJson(json.decode(user)));
                    } else {
                      return const Text('User details not found.');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
      },
    );
  }
}
