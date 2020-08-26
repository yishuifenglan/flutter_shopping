import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/widgets/load_image.dart';

class CommentTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommentTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colours.bg_color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
            ClipOval(
              child: LoadAssetImage('bank/head',height: 38,width: 38,),


            )

              ])
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(116);
}
