import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurene_app/screens/home_screen.dart';
import 'package:nurene_app/themes/app_colors.dart';
import '../widgets/button_widget.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../blocs/login/login_bloc.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_field_widget.dart';
import '../utils/GeolocatorUtil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Delay the sliding animation for a smooth effect
    Future.delayed(Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    GeolocatorUtil.checkLocationServices(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7882A4), Colors.pinkAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: const LogoWidget(
                        height: 140,
                        width: 140,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      "Welcome! Please login to continue",
                      style: GoogleFonts.cormorantGaramond(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: _slideAnimation,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: 
                          BorderRadius.all(Radius.circular(20))
                          ,
                        ),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                          child: Column(
                            children: [
                              TextFieldWidget(
                                label: 'Username',
                                controller: usernameController,
                              ),
                              const SizedBox(height: 30),
                              TextFieldWidget(
                                label: 'Password',
                                controller: passwordController,
                                isPassword: true,
                              ),
                              const SizedBox(height: 40),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return const CircularProgressIndicator();
                                  } else if (state is LoginSuccess) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeScreen(user: state.user),
                                        ),
                                      );
                                    });
                                    return const SizedBox.shrink();
                                  } else {
                                    return ButtonWidget(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      },
                                      label: 'Login',
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF7882A4),
                                          Color.fromARGB(255, 159, 170, 205),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
