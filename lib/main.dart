import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shopping/provider/theme_provider.dart';
import 'package:flutter_shopping/routers/routers.dart';
import 'package:flutter_shopping/ui/splash/page/splash_page.dart';
import 'package:flutter_shopping/util/device_utils.dart';
import 'package:flutter_shopping/util/log_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'localization/app_localizations.dart';
import 'net/dio_utils.dart';
import 'net/http_api.dart';
import 'net/intercept.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// sp初始化
  await SpUtil.getInstance();
  runApp(MyApp());
  if (Device.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final Widget home;
  final ThemeData theme;

  MyApp({this.home, this.theme}) {
    Log.init();
    initDio();
    Routes.initRoutes();
  }

  void initDio() {
    final List<Interceptor> interceptors = [];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());

    /// 刷新Token
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
//    if (!Constant.inProduction) {
    interceptors.add(LoggingInterceptor());
//    }
    /// 适配数据(根据自己的数据结构，可自行选择添加)
//    interceptors.add(AdapterInterceptor());
    setInitDio(
      baseUrl: Api.BASE_URL,
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              theme: theme ?? provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: home ?? SplashPage(),
              onGenerateRoute: Routes.router.generator,
              localizationsDelegates: const [
//                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const <Locale>[
                Locale('zh', 'CN'),
                Locale('en', 'US')
              ],
              builder: (context, child) {
                /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
