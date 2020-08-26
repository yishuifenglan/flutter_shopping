import 'package:fluro/fluro.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/bank/page/bank_page.dart';
import 'package:flutter_shopping/ui/message/page/message_page.dart';
import 'package:flutter_shopping/ui/setting/page/setting_page.dart';

class SettingRouter extends IRouterProvider{

  static String settingPage = '/ui/setting';
  @override
  void initRouter(Router router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, __) => SettingPage()));
  }

}