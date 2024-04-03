import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chats_screen/login.dart';
import 'package:temp_house/presentation/chats_screen/view/chats_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return  ChatsScreen();
          }
          else{
            return LoginScreenTest();
          }
        },
      ),
    );
  }
}
