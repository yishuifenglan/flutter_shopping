import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/login/login_router.dart';
import 'package:flutter_shopping/util/log_utils.dart';
import 'package:oktoast/oktoast.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _comPsdController = TextEditingController();
  String error = "Inconsistent passwords";

  bool _clickable = false;

  @override
  void initState() {
    super.initState();
    _comPsdController.addListener(() {
      _comPad();
    });
    _psdController.addListener(() {
      _comPad();
    });
  }

  void _comPad() {
    String psd = _psdController.text;
    String comPsd = _comPsdController.text;
    if (psd == comPsd) {
      _clickable = true;
      setState(() {
        error = '';
      });
    } else {
      _clickable = false;
      setState(() {
        error = "Inconsistent passwords";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: AppBar(
        backgroundColor: Colours.login_input_bg_color,
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Please recharge password here',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colours.login_input_bg_color,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: _psdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'input password',
                        hintStyle: TextStyle(
                            color: Colours.text_gray_c, fontSize: 17)),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 56,
                  color: Colours.login_input_bg_color,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                      controller: _comPsdController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'confirm password',
                          errorText: error,
                          hintStyle: TextStyle(
                              color: Colours.text_gray_c, fontSize: 17)),
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 15,
              right: 15,
              child: CupertinoButton(
                onPressed: _clickable
                    ? () {
                        NavigatorUtils.push(context, LoginRouter.loginPage,
                            clearStack: true);
                      }
                    : null,
                disabledColor: _clickable
                    ? Colours.forget_psd_color
                    : Colours.unselected_item_color,
                color: Colours.forget_psd_color,
                child: Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
