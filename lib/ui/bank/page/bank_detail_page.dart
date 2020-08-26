import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/app_navigator.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/home/page/webview_page.dart';
import 'package:flutter_shopping/util/utils.dart';
import 'package:flutter_shopping/widgets/load_image.dart';
import 'package:flutter_shopping/widgets/start_bar.dart';

class BankDetailPage extends StatelessWidget {
  final String title;

  const BankDetailPage({Key key, this.title}) : super(key: key);

  Widget lightWidget(IconData data,String des,GestureTapCallback onTap){
    return  InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 105,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF1C1C1E)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data,size: 25,color: Colors.blue,),
              Text(des,style: TextStyle(fontSize: 11,color: Colors.blue),)
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2C2C2E),
        appBar: AppBar(
          backgroundColor: Colours.map_search_bg_color,
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Letha Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Letha Bank ATM-1.9 Km',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              FStarRating(
                rating: 3.6,
                maxRating: 5,
                size: 20,
                selectedColor: Colors.red,
                unselectedColor: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 12, 0),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Directions',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        '15 Mins Drive',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ]),
              ),
              Container(
                height: 150,
                margin: EdgeInsets.fromLTRB(0, 20, 12, 12),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LoadImage(
                            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598419726356&di=50333584b466de15db12513795c43ebc&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F05%2F81%2F09%2F125c32eed0d64de.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LoadImage(
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598419726355&di=8384b60aef748c8cc762c36c7c045332&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F04%2F62%2F76%2F96587086d0edcfb.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LoadImage(
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598419726354&di=a6570ac85ba8262126f7e5f56a5f5f0f&imgtype=0&src=http%3A%2F%2Fpic.616pic.com%2Fbg_w1180%2F00%2F03%2F34%2FAXae2808oj.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  lightWidget(Icons.phone,'Call',(){
                    Utils.launchTelURL('10086');
                  }),
                  lightWidget(Icons.email,'Hotline',(){

                  }),
                  lightWidget(Icons.star,'Saved',(){

                  }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Hours',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,5,0,15),
                child: Text(
                  '24h,Open Now',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              Divider(
              height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Address',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,5,0,15),
                child: Text(
                  'Seftigenstrass 240 3084 Switzerland Warbern',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Website',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              GestureDetector(
                  onTap: () {
                   AppNavigator.push(context, WebViewPage(url: 'https://www.baidu.com',title: 'baidu',));
                  },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,5,0,15),
                  child: Text(
                    'Https://www.boc.cn/',
                    style: TextStyle(color: Colors.white, fontSize: 11,
                    decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          ),
        ));
  }
}
