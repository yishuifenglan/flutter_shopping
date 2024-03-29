
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/bank/bank_router.dart';
import 'package:flutter_shopping/ui/home/page/home_page.dart';
import 'package:flutter_shopping/ui/home/page/webview_page.dart';
import 'package:flutter_shopping/ui/login/login_router.dart';
import 'package:flutter_shopping/ui/map/map_router.dart';
import 'package:flutter_shopping/ui/message/message_router.dart';
import 'package:flutter_shopping/ui/setting/setting_router.dart';


import 'not_found_page.dart';



// ignore: avoid_classes_with_only_static_members
class Routes {
  static String home = '/ui.home';
  static String webViewPage = '/webview';

  static final List<IRouterProvider> _listRouter = [];

  static final Router router = Router();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          debugPrint('未找到目标页');
          return NotFoundPage();
        });

    router.define(home, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(MessageRouter());
    _listRouter.add(SettingRouter());
    _listRouter.add(BankRouter());
    _listRouter.add(MapRouter());


    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
