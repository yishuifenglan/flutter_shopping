
import 'package:fluro/fluro.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/login/page/forget_page.dart';
import 'package:flutter_shopping/ui/login/page/update_page.dart';
import 'page/login_page.dart';



class LoginRouter implements IRouterProvider{

  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String forgetPage = '/login/forgetPassword';
  static String resetPage = '/login/resetPage';
  
  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, __) => LoginPage()));
//    router.define(registerPage, handler: Handler(handlerFunc: (_, __) => RegisterPage()));
//    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, __) => SMSLoginPage()));
    router.define(forgetPage, handler: Handler(handlerFunc: (_, __) => ForgetPage()));
    router.define(resetPage, handler: Handler(handlerFunc: (_, __) => UpdatePage()));
  }
  
}