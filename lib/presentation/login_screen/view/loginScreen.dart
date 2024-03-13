import 'package:flutter/material.dart';
import 'package:temp_house/presentation/login_screen/view/widgets/loginBody.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}
