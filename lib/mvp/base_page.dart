
import 'package:flutter/material.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/util/dialog/dialog_utils.dart';
import 'package:flutter_shopping/util/log_utils.dart';
import 'package:flutter_shopping/util/toast.dart';
import 'package:flutter_shopping/widgets/progress_dialog.dart';
import 'base_presenter.dart';
import 'mvps.dart';

mixin BasePageMixin<T extends StatefulWidget, P extends BasePresenter> on State<T> implements IMvpView {

  P presenter;

  P createPresenter();
  
  @override
  BuildContext getContext() {
    return context;
  }
  
  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  bool _isShowDialog = false;

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showTransparentDialog<void>(
          context: context,
          barrierDismissible: false,
          builder:(_) {
            return WillPopScope(
              onWillPop: () async {
                // 拦截到返回键，证明dialog被手动关闭
                _isShowDialog = false;
                return Future.value(true);
              },
              child: buildProgress(),
            );
          },
        );
      } catch(e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    Toast.show(string);
  }
  
  /// 可自定义Progress
  Widget buildProgress() => const ProgressDialog(hintText: '正在加载...');

  @override
  void didChangeDependencies() {
    presenter?.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    presenter?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    presenter?.deactivate();
    Log.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    presenter?.didUpdateWidgets<T>(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    presenter = createPresenter();
    presenter?.view = this;
    presenter?.initState();
    super.initState();
  }
  
}