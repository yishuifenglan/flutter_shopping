
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/util/log_utils.dart';

import 'dio_utils.dart';
import 'error_handle.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
//    String studentId = SpUtil.getString(Args.SP_USER_ID);
    final String accessToken = '';
    if (accessToken.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options);
  }
}

class TokenInterceptor extends Interceptor {
  String accessToken;

  Future<String> getToken() async {
//    final Map<String, String> params = <String, String>{};
//    params['userPhone'] = SpUtil.getString(Args.PARENT_USERID);
//    params['userPwd'] = SpUtil.getString(Args.PARENT_PASSWORD);
//    try {
//      _tokenDio.options = DioUtils.instance.dio.options;
//      final Response response =
//          await _tokenDio.post(Api.PARENT_LOGIN, queryParameters: params);
//      if (response.statusCode == ExceptionHandle.success) {
//        final String data = response.data.toString();
//        final bool isCompute =
//            !Constant.isDriverTest && data.length > 10 * 1024;
//        final Map<String, dynamic> _map =
//            isCompute ? await compute(parseData, data) : parseData(data);
//        List<LoginBeanEntity> list =
//            BaseEntity<List<LoginBeanEntity>>.fromJson(_map).data;
//        String studentId = SpUtil.getString(Args.SP_USER_ID);
//        for (int i = 0; i < list.length; i++) {
//          if (studentId == list[i].userid) {
//            SpUtil.putString(studentId + Args.STUDENT_TOKEN, list[i].userpwd);
//            accessToken = list[i].userpwd;
//          }
//        }
//        Log.e('获取token成功== $accessToken');
//        return accessToken;
//      }
//    } catch (e) {
//      Log.e('刷新Token失败！');
//    }
    return null;
  }

  Dio _tokenDio = Dio();

  @override
  Future<Object> onResponse(Response response) async {
    //401代表token过期
    if (response != null &&
        response.statusCode == ExceptionHandle.unauthorized) {
      if (!response.data.toString().contains('token')) {
        return super.onResponse(response);
      }
      Log.d('-----------自动刷新Token------------');
      final Dio dio = DioUtils.instance.dio;
      dio.interceptors.requestLock.lock();
      final String accessToken = await getToken(); // 获取新的accessToken
      Log.e('-----------NewToken: $accessToken ------------');
      SpUtil.putString(Constant.accessToken, accessToken);
      dio.interceptors.requestLock.unlock();

      if (accessToken != null) {
        // 重新请求失败接口
        final RequestOptions request = response.request;
        request.headers['Authorization'] = 'Bearer $accessToken';
        try {
          Log.e('----------- 重新请求接口 ------------');

          /// 避免重复执行拦截器，使用tokenDio
          final Response response = await _tokenDio.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }
    return super.onResponse(response);
  }
}

class LoggingInterceptor extends Interceptor {
  DateTime _startTime;
  DateTime _endTime;

  @override
  Future onRequest(RequestOptions options) {
    _startTime = DateTime.now();
    Log.d('----------Start----------');
    if (options.queryParameters.isEmpty) {
      Log.d('RequestUrl: ' + options.baseUrl + options.path);
    } else {
      Log.d('RequestUrl: ' +
          options.baseUrl +
          options.path +
          '?' +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d('RequestMethod: ' + options.method);
    Log.d('RequestHeaders:' + options.headers.toString());
    Log.d('RequestContentType: ${options.contentType}');
    Log.d('RequestData: ${options.data.toString()}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    _endTime = DateTime.now();
    int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success) {
      Log.d('ResponseCode: ${response.statusCode}');
    } else {
      Log.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    Log.json(response.data.toString());
    Log.d('----------End: $duration 毫秒----------');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    Log.d('----------Error-----------');
    return super.onError(err);
  }
}
