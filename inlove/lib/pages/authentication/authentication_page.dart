import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/pages/authentication/authentication_state.dart';
import 'package:inlove/pages/authentication/authorization_component.dart';
import 'package:inlove/pages/authentication/registration_component.dart';

import 'package:inlove/pages/home/home_page.dart';

class AuthorizationPage extends StatefulWidget {
  static const routeName = '/authorizationPage';
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>
    with SingleTickerProviderStateMixin {
  final AuthorizationCubit _authorizationCubit = AuthorizationCubit();

  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _passswordController = TextEditingController();

  @override
  void initState() {
    //TODO _nameController.addListener(() {});
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    void _openMainPage() {
      Navigator.pushNamed(context, HomePage.routeName);
    }

    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
        bloc: _authorizationCubit,
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: state.showAuthorizationComponent
                    ? AuthorizationComponent(
                        size: _size,
                        opacity: _opacity,
                        transform: _transform,
                        authorizationCubit: _authorizationCubit,
                        openMainPage: _openMainPage,
                        nameFieldController: _nameController,
                        mailFieldController: _mailController,
                        passwordFieldController: _passswordController,
                      )
                    : RegistrationComponent(
                        size: _size,
                        opacity: _opacity,
                        transform: _transform,
                        authorizationCubit: _authorizationCubit,
                        openMainPage: _openMainPage,
                        nameFieldController: _nameController,
                        mailFieldController: _mailController,
                        passwordFieldController: _passswordController,
                      ),
              ),
            ),
          );
        });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}