import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/widgets/double_tap_back_exit_app.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: Scaffold(
        body: SafeArea(
          child: Text('home'),

        ),

      ),
    );
  }
}
