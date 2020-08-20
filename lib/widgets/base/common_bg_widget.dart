import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/widgets/load_image.dart';

class CommonWidget extends StatefulWidget {
  final Widget child;

  final PageState state;

  final GestureTapCallback onTap;

  const CommonWidget({Key key, this.child, this.state, this.onTap})
      : super(key: key);

  @override
  _CommonWidgetState createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> {

  Widget commentWidget(String image, String text, bool isClick) {
    return GestureDetector(
      onTap: isClick ? widget.onTap : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadAssetImage(image,width: 50,height: 50,fit: BoxFit.scaleDown),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              10,
              0,
              0,
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget mBody() {
    switch (widget.state) {
      case PageState.CONTENT:
        return widget.child;
      case PageState.PROGRESS:
        return commentWidget("home/logo_decoloring", '加载中...',false);
      case PageState.EMPTY:
        return commentWidget("home/picture_content_empty", '这里没有数据~~',true);
      case PageState.ERROR:
        return commentWidget(
            "home/picture_network_abnormal", "当前网络不佳\n点击屏幕重新加载",true);
    }
    return widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: mBody(),
      ),
    );
  }
}

enum PageState { CONTENT, PROGRESS, EMPTY, ERROR }

extension PageStateExtension on PageState {
  String get values => ['CONTENT', 'PROGRESS', 'EMPTY', 'ERROR'][index];
}
