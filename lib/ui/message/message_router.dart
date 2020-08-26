import 'package:fluro/fluro.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/bank/page/bank_page.dart';
import 'package:flutter_shopping/ui/message/page/message_page.dart';

class MessageRouter extends IRouterProvider{

  static String messagePage = '/ui/message';
  @override
  void initRouter(Router router) {
    router.define(messagePage, handler: Handler(handlerFunc: (_, __) => MessagePage()));
  }

}