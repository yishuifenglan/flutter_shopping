
import 'package:barcode_scan/barcode_scan.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';



class Utils {

  /// 调起拨号页
  static void launchTelURL(String phone) async {
    final String url = 'tel:'+ phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败！');
    }
  }

  /// 调起二维码扫描页
  static Future<String> scan() async {
    try {
      const ScanOptions options = ScanOptions(
        strings: {
          'cancel': '取消',
          'flash_on': '开启闪光灯',
          'flash_off': '关闭闪光灯',
        },
      );
      final ScanResult result = await BarcodeScanner.scan(options: options);
      return result.rawContent;
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == BarcodeScanner.cameraAccessDenied) {
          Toast.show('没有相机权限！');
        }
      }
    }
    return null;
  }

  static String formatPrice(String price, {MoneyFormat format = MoneyFormat.END_INTEGER}){
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price), MoneyUnit.YUAN, format: format);
  }


}

