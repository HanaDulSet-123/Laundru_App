import 'package:flutter/material.dart';
import 'package:laudry_app/extention/extention.dart';
import 'package:laudry_app/preference/shared_preference.dart';
import 'package:laudry_app/view/login_screen.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        PreferenceHandler.removeLogin();
        context.pushReplacementNamed(LoginAPIScreen.id);
      },
      child: Text("Keluar"),
    );
  }
}

