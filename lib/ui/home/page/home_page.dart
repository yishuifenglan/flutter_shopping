import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/bank/page/bank_page.dart';
import 'package:flutter_shopping/ui/home/provider/home_provider.dart';
import 'package:flutter_shopping/ui/message/message_router.dart';
import 'package:flutter_shopping/ui/message/page/message_page.dart';
import 'package:flutter_shopping/ui/setting/page/setting_page.dart';
import 'package:flutter_shopping/widgets/double_tap_back_exit_app.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final PageController _pageController = PageController();
  List<Widget> _pageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      BankPage(),
      MessagePage(),
      SettingPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.message),
            onPressed: () {
              NavigatorUtils.push(context, MessageRouter.messagePage);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colours.login_input_bg_color,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomItem(currentIndex, 0, Icons.home, "首页"),
                buildBottomItem(currentIndex, -1, null, "搜索"),
                buildBottomItem(currentIndex, 2, Icons.settings, "设置"),
              ],
            ),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (int index) {
              return currentIndex = index;
            },
            children: _pageList,
          )),
    );
  }

  buildBottomItem(int selectIndex, int index, IconData iconData, String title) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize = 20;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);
    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 13.0, color: Colors.blue);
      //选中状态的按钮样式
      iconColor = Colors.blue;
      iconSize = 25;
      padding = EdgeInsets.only(top: 6.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        child: Container(
          color: Colours.login_input_bg_color,
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }
}
