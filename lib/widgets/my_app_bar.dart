
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/res/dimens.dart';
import 'package:flutter_shopping/res/gaps.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.onPressed,
    this.isBack = true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {


    final SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light;

    Widget back = isBack ? IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.maybePop(context);
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
        color: Colors.black
      ),
    ) : Gaps.empty;

    Widget action = actionName.isNotEmpty ? Positioned(
      right: 0.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            minWidth: 60.0,
          ),
        ),
        child: FlatButton(
          child: Text(actionName, key: const Key('actionName')),
          textColor: Colours.text,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    ) : Gaps.empty;

    Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: TextStyle(fontSize: Dimens.font_sp18,),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
