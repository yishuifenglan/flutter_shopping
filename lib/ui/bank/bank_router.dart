import 'package:fluro/fluro.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/bank/page/bank_detail_page.dart';
import 'package:flutter_shopping/ui/bank/page/bank_page.dart';

class BankRouter extends IRouterProvider{

  static String bankPage = '/ui/bank';
  static String bankDetailPage = '/ui/bankDetail';
  @override
  void initRouter(Router router) {
    router.define(bankPage, handler: Handler(handlerFunc: (_, __) => BankPage()));
    router.define(bankDetailPage, handler: Handler(handlerFunc: (_, __) => BankDetailPage()));
  }

}