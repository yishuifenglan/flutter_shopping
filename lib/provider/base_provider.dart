import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping/widgets/base/common_bg_widget.dart';

abstract class BaseProvider extends ChangeNotifier{


  PageState _mPageState;

  PageState get pageState =>_mPageState;


  setPageState(PageState pageState){
    _mPageState = pageState;
    notifyListeners();
  }


}