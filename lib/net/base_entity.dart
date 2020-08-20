

import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {

  String errorCode;
  String errorMsg;
  T data;
  String result;

  BaseEntity.fromJson(Map<String, dynamic> json) {
    errorCode = json[Constant.code] as String;
    errorMsg = json[Constant.message] as String;
    result = json[Constant.result] as String;
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ<T>(json[Constant.data]);
    }
  }

  BaseEntity(this.errorCode, this.errorMsg, this.data,{this.result});

  T _generateOBJ<T>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}