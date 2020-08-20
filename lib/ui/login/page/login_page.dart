import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/provider/change_notifier_manage.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/app_navigator.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/routers/routers.dart';
import 'package:flutter_shopping/ui/login/login_router.dart';
import 'package:flutter_shopping/ui/login/page/forget_page.dart';
import 'package:flutter_shopping/ui/login/wigets/my_text_field.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ChangeNotifierMixin<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  bool isFos = false;

  String name;

  @override
  void initState() {
    super.initState();
    String name = SpUtil.getString(Constant.phone);
    if (name.isNotEmpty) {
      isFos = true;
      _nameController.text = name;
    }
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      if (mounted) {
        setState(() {
          _clickable = clickable;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(fontSize: 34, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Enter your account and password to login',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colours.login_input_bg_color,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: MyTextField(
                      autoFocus: !isFos,
                      controller: _nameController,
                      focusNode: _nodeText1,
                      maxLength: 11,
                    keyboardType: TextInputType.phone,
                    labelText: 'Phone :',
                    ),
                  ),
                  Container(
                    color: Colours.login_input_bg_color,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: MyTextField(
                      controller: _passwordController,
                      focusNode: _nodeText2,
                      labelText: 'Password :',
                      autoFocus: isFos,
                      isInputPwd: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.push(
                          context, ForgetPage(phone: _nameController.text,));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Forget your password ?',
                        style: TextStyle(color: Colours.forget_psd_color),
                      ),
                    ),
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
                    _login();
                  }
                      : null,
                  disabledColor: _clickable
                      ? Colours.forget_psd_color
                      : Colours.unselected_item_color,
                  color: Colours.forget_psd_color,
                  child: Text('Login In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    SpUtil.putString(Constant.phone, _nameController.text);
    NavigatorUtils.push(context, Routes.home,clearStack: true);
  }
}
