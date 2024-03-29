import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shopping/net/dio_utils.dart';
import 'package:flutter_shopping/net/error_handle.dart';
import 'package:flutter_shopping/net/http_api.dart';
import 'package:meta/meta.dart';

import 'base_presenter.dart';
import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {
  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回Future 适用于刷新，加载更多
  Future requestNetwork<T>(
    Method method, {
    @required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T> onSuccess,
    NetErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    if (isShow) view.showProgress();
    return DioUtils.instance.requestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isClose) view.closeProgress();
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (code, msg) {
        view.showError();
        _onError(code.toString(), msg, onError);
      },
    );
  }



  /// 上传图片实现
  Future<String> uploadImg(File image) async {
    String imgPath = '';
    try {
      final String path = image.path;
      final String name = path.substring(path.lastIndexOf('/') + 1);
      final FormData formData = FormData.fromMap(
          {'uploadIcon': await MultipartFile.fromFile(path, filename: name)});
      await requestNetwork<String>(Method.post,
          url: Api.BASE_8888_HOST, params: formData, onSuccess: (data) {
        imgPath = data;
      });
    } catch (e) {
      view.showToast('图片上传失败！');
    }
    return imgPath;
  }

  void _onError(String code, String msg, NetErrorCallback onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error.toString()) {
      view.showToast(msg);
    }

    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code.toString(), msg);
    }
  }
}
