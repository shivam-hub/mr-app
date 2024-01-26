// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurene_app/screens/home_screen/home_screen.dart';
import '../../widgets/button_widget.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../../blocs/login/login_bloc.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../utils/GeolocatorUtil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  GeolocatorUtil geolocatorUtil = GeolocatorUtil();

  @override
  void initState() {
    super.initState();
    geolocatorUtil.checkLocationServices(context);
    _initAnimation();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
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
          _buildColumn(),
        ],
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogoWidget(),
        const SizedBox(height: 60),
        _buildWelcomeText(),
        const SizedBox(height: 20),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildCard(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 150),
      child: LogoWidget(
        height: 140,
        width: 140,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      "Welcome! Please login to continue",
      style: GoogleFonts.cormorantGaramond(
        textStyle: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCard() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      color: Colors.white,
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent() {
    return Container(
      height: 350,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        children: [
          _buildTextField('Username', usernameController),
          const SizedBox(height: 20),
          _buildTextField('Password', passwordController, isPassword: true),
          const SizedBox(height: 30),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
        ),
        onChanged: (_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        } else if (state is LoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(user: state.user),
              ),
            );
          });
          return const SizedBox.shrink();
        } else {
          return Column(
            children: [
              if (state is LoginFailure)
                const Center(
                  child: Text(
                    "Username or Password Entered is incorrect",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),
              ButtonWidget(
                onPressed: () async {
                  try {
                    await geolocatorUtil.checkLocationServices(context);
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(
                        username: usernameController.text,
                        password: passwordController.text,
                      ),
                    );
                  } catch (e) {
                    debugPrint("error $e");
                  }
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
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
