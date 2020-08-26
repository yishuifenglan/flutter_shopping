import 'package:fluro/fluro.dart';
import 'package:flutter_shopping/routers/router_init.dart';
import 'package:flutter_shopping/ui/map/page/map_page.dart';

class MapRouter extends IRouterProvider{

  static String mapPage = '/ui/map';
  @override
  void initRouter(Router router) {
    router.define(mapPage, handler: Handler(handlerFunc: (_, __) => MapPage()));
  }

}