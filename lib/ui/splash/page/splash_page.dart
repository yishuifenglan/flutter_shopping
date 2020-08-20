import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/login/login_router.dart';
import 'package:flutter_shopping/util/image_utils.dart';
import 'package:flutter_shopping/widgets/indicator/dots_indicator.dart';
import 'package:flutter_shopping/widgets/load_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

///https://www.cnblogs.com/wpt80/p/12484373.html 解决白屏问题 需要设置
class _SplashPageState extends State<SplashPage> {
  int _status = 0;

  StreamSubscription _subscription;

  final List<String> _guideList = ['gui1', 'gui2'];

  static const _kDuration = const Duration(milliseconds: 300);

  final List<String> _strList = [
    'Home for all your financial needs. Ours purpose is to help make financial lives better.',
    'Your demand is our pursuit, we will provide you with the most professional and safest guarantee'
  ];

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initSplash() {
    Future.delayed(Duration(seconds: 2), () {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
//        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      body: _status == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LoadAssetImage(
                      'splash_icon',
                      width: 106,
                      height: 100,
                    ),
                  ),
                  Text(
                    'HAPPY BANK',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    'WHAT CAN WE DO FOR YOU',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _guideList.length,
                  itemBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                _guideList[index],
                                key: Key(_guideList[index]),
                                fit: BoxFit.cover,
                                width: 292,
                                height: 292,
                              ),
                              Text(
                                _strList[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: index == _strList.length - 1 ? true : false,
                          child: Positioned(
                            bottom: 80,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _goLogin(),
                              child: LoadAssetImage(
                                'start',
                                width: 141,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: DotsIndicator(
                    color: Colors.blue,
                    controller: _pageController,
                    itemCount: _strList.length,
                    onPageSelected: (page) {
                      _pageController.animateToPage(page,
                          duration: _kDuration, curve: Curves.ease);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
