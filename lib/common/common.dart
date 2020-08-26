import 'package:flutter/foundation.dart';

class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'errorMsg';
  static const String result = 'result';
  static const String code = 'errorCode';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';

  //家的经度
  static const String HOME_LAT = 'home_lat';

  //家的维度
  static const String HOME_LON = 'home_lon';

  //公司的经度
  static const String COMPANY_LAT = 'company_lat';

  //公司的维度
  static const String COMPANY_LON = 'company_lon';


}
