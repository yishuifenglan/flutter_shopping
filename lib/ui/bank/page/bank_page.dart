import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/app_navigator.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/home/page/webview_page.dart';
import 'package:flutter_shopping/ui/map/map_router.dart';
import 'package:flutter_shopping/util/image_utils.dart';
import 'package:flutter_shopping/widgets/comment_title.dart';
import 'package:flutter_shopping/widgets/load_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:infinite_cards/infinite_cards.dart';
import 'dart:math' as math;

class BankPage extends StatefulWidget {
  @override
  _BankPageState createState() => _BankPageState();
}


class _BankPageState extends State<BankPage>
    with AutomaticKeepAliveClientMixin {
  AnimationController _animationController = AnimationController(vsync: null);
  List<String> _imageList = [
    'bank/banner1',
    'bank/banner2',
    'bank/banner3',
    'bank/banner4',
    'bank/banner5'
  ];

  List<String> _grvList = [
    'bank/bank',
    'bank/money',
    'bank/trend',
    'bank/form'
  ];

  List<String> _conentImageList = ['bank/list1', 'bank/list2', 'bank/list3'];
  List<String> _contentTitleList = ['Restaurant', 'Hospital', 'Wifi'];
  List<String> _contentList = [
    'Ankan Luxury Bar',
    'Letha Hospital',
    'Ankerman Wifi'
  ];

  List<String> _introList = ['Branch', 'Exchange', 'Interest Rate', 'Market'];

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      _animationController.addStatusListener((status) {

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: CommentTitle(
        title: 'Home',
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Divider(
                height: 1.0,
                color: Colors.white,
              ),
              Container(
                height: 200,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: new Swiper(
                  duration: 2000,
                  itemBuilder: (BuildContext context, int index) {
                    return LoadAssetImage(
                      _imageList[index],
                      format: ImageFormat.jpg,
                      fit: BoxFit.fill,
                    );
                  },
                  viewportFraction: 0.8,
                  scale: 0.9,
                  autoplay: true,
                  itemCount: _imageList.length,
                  pagination: new SwiperPagination(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GridView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _grvList.length,
                  itemBuilder: (context, index) {
                    return getItemContainer(index, context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _conentImageList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1.0, color: Colors.white30),
                  itemBuilder: (context, index) {
                    return listItem(index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return SizedBox(
      height: 74,
      child: Stack(
        children: [
          Row(
            children: [
              LoadAssetImage(
                _conentImageList[index],
                width: 35,
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _contentTitleList[index],
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      _contentList[index],
                      style: TextStyle(color: Colours.dark_text, fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colours.dark_text,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget getItemContainer(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            NavigatorUtils.push(context, MapRouter.mapPage);
            break;
          case 1:
         NavigatorUtils.goWebViewPage(context, '作者博客', 'https://www.sandbox.paypal.com/c2/signin');
            break;
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 162,
        width: 162,
        child: Stack(children: [
          LoadAssetImage(
            _grvList[index],
            height: 162,
            width: 162,
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              _introList[index],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
