import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/provider/change_notifier_manage.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/login/login_router.dart';
import 'package:flutter_shopping/ui/login/wigets/my_text_field.dart';
import 'package:flutter_shopping/util/log_utils.dart';

class ForgetPage extends StatefulWidget {
  final String phone;

  const ForgetPage({Key key, this.phone}) : super(key: key);

  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage>
    {
  //定义变量
  StreamSubscription<int> _subScription;

  //倒计时数值
  var countdownTime = 0;

  bool _clickable = false;

  final TextEditingController _verController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.phone;
    _verController.addListener(() {
      _verify();
    });
    _nameController.addListener(() {
      _verify();
    });
  }

  void _verify() {
    final String verification = _verController.text;
    final String name = _nameController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11||verification.isEmpty|| verification.length < 6) {
      clickable = false;
    }else{
      clickable = true;
    }
    /// 状态不一样在刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  //倒计时方法
  startCountdown() {
    countdownTime = 60;
    _subScription = Stream.periodic(Duration(seconds: 1), (int i) => i)
        .take(60)
        .listen((int i) {
          if(mounted){
            setState(() {
              if (countdownTime < 1) {
                _subScription.cancel();
              } else {
                countdownTime -= 1;
              }
            });
          }

    });
  }

  @override
  void dispose() {
    _subScription?.cancel();
    _subScription =null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: AppBar(
        backgroundColor: Colours.login_input_bg_color,
        title: Text(
          'Forget Password',
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
                  'Forget Password',
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Please enter your information to find your password',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colours.login_input_bg_color,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: _nameController,
                    enabled: widget.phone.isNotEmpty?false:true,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: widget.phone.isNotEmpty?widget.phone:'please input phone',
                        hintStyle:
                            TextStyle(color: Colours.text_gray_c, fontSize: 17)),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),

                ),
                Container(
                  alignment: Alignment.center,
                  height: 56,
                  color: Colours.login_input_bg_color,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Stack(
                    children: [
                      TextField(
                        controller: _verController,
                          maxLength: 6,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'verify code',
                              hintStyle:
                                  TextStyle(color: Colours.text_gray_c, fontSize: 17)),
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      Positioned(
                          right: 10,
                          child: GestureDetector(
                            onTap: () => startCountdown(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                countdownTime > 0
                                    ? "${countdownTime}s"
                                    : "verify code",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ))
                    ],
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
               NavigatorUtils.push(context, LoginRouter.resetPage,replace: true);
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
