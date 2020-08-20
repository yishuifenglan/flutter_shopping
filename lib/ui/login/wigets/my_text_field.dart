import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/res/gaps.dart';
import 'package:flutter_shopping/widgets/load_image.dart';

/// 登录模块的输入框封装
class MyTextField extends StatefulWidget {
  const MyTextField(
      {Key key,
      @required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.focusNode,
      this.isInputPwd = false,
      this.getVCode,
      this.keyName,
      this.labelText})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;

  /// 用于集成测试寻找widget
  final String keyName;
  final String labelText;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller?.removeListener(isEmpty);
    super.dispose();
  }

  Future _getVCode() async {
    bool isSuccess = await widget.getVCode();
    if (isSuccess != null && isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i)
          .take(_second)
          .listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;
    final TextField textField = TextField(
        textAlign: TextAlign.center,
        focusNode: widget.focusNode,
        maxLength: widget.maxLength,
        obscureText: widget.isInputPwd ? !_isShowPwd : false,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
        // 数字、手机号限制格式为0到9， 密码限制不包含汉字
        inputFormatters: (widget.keyboardType == TextInputType.number ||
                widget.keyboardType == TextInputType.phone)
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
            : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))],
        decoration: InputDecoration(
            labelText: widget.labelText!=null ?widget.labelText:null,
            hintText: 'compulsory',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle: TextStyle(color: Colors.white, fontSize: 17)),
        style: TextStyle(color: Colors.white, fontSize: 17));

    Widget clear = Semantics(
      label: '清空',
      hint: '清空输入框',
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: LoadAssetImage(
            'login/qyg_shop_icon_delete',
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
        ),
        onTap: () => widget.controller.text = '',
      ),
    );

    Widget pwdVisible = Semantics(
      label: '密码可见开关',
      hint: '密码是否可见',
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: LoadAssetImage(
            _isShowPwd
                ? 'login/qyg_shop_icon_display'
                : 'login/qyg_shop_icon_hide',
            key: Key('${widget.keyName}_showPwd'),
            width: 18.0,
            height: 40.0,
          ),
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_isShowDelete) Gaps.empty else clear,
            if (!widget.isInputPwd) Gaps.empty else Gaps.hGap15,
            if (!widget.isInputPwd) Gaps.empty else pwdVisible,
          ],
        )
      ],
    );
  }
}
