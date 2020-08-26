import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_shopping/common/common.dart';
import 'package:flutter_shopping/res/colors.dart';
import 'package:flutter_shopping/routers/app_navigator.dart';
import 'package:flutter_shopping/routers/fluro_navigator.dart';
import 'package:flutter_shopping/ui/bank/bank_router.dart';
import 'package:flutter_shopping/ui/bank/page/bank_detail_page.dart';
import 'package:flutter_shopping/util/log_utils.dart';
import 'package:flutter_shopping/widgets/search_bar.dart';
import 'package:oktoast/oktoast.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<PoiSearch> _list = [];
  int _index = 0;
  final ScrollController _controller = ScrollController();
  AMap2DController _aMap2DController;

  Widget saveItem(IconData icons, String title, GestureTapCallback callback) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: GestureDetector(
        onTap: callback,
        child: Column(
          children: [
            ClipOval(
              child: Container(
                  height: 70,
                  width: 70,
                  alignment: Alignment.center,
                  color: Color(0xFF3C3C3E),
                  child: Icon(
                    icons,
                    color: Colors.blue,
                    size: 40,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchBar(
        hintText: '搜索地址',
        onPressed: (text) {
          _controller.animateTo(0.0,
              duration: Duration(milliseconds: 10), curve: Curves.ease);
          _index = 0;
          if (_aMap2DController != null) {
            _aMap2DController.search(text, city: '西安');
          }
        },
      ),
      body: SafeArea(
        child: Container(
          color: Colours.map_search_bg_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 9,
                child: AMap2DView(
                  webKey: '84548d9c59bd03ea8371f7e16efe7b33',
                  onPoiSearched: (result) {
                    _controller.animateTo(0.0,
                        duration: Duration(milliseconds: 10),
                        curve: Curves.ease);
                    _index = 0;
                    _list = result;
                    setState(() {});
                  },
                  onAMap2DViewCreated: (controller) {
                    _aMap2DController = controller;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Column(
                  children: [
                    Text(
                      'Saved Location',
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(
                      height: 1,
                      indent: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 10, 0, 0),
                      child: Row(
                        children: [
                          saveItem(Icons.home, 'Home', () {
                            _aMap2DController.move('34.288465', '108.985633');
                          }),
                          saveItem(Icons.domain, 'Company', () {
                            _aMap2DController.move('34.228135', '108.903013');
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView.separated(
                  controller: _controller,
                  itemCount: _list.length,
                  separatorBuilder: (_, index) => const Divider(),
                  itemBuilder: (_, index) {
                    return _AddressItem(
                      isSelected: _index == index,
                      date: _list[index],
                      onTap: () {
                        _index = index;
                        if (_aMap2DController != null) {
                          _aMap2DController.move(
                              _list[index].latitude, _list[index].longitude);
                        }
                        setState(() {});
                      },
                      onMore: () {
                        AppNavigator.push(
                            context,
                            BankDetailPage(
                              title: _list[index].title,
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {
  const _AddressItem({
    Key key,
    @required this.date,
    this.isSelected = false,
    this.onTap,
    this.onMore,
  }) : super(key: key);

  final PoiSearch date;
  final bool isSelected;
  final GestureTapCallback onTap;

  final GestureTapCallback onMore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 76,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipOval(
                child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    color: Color(0xFF28282A),
                    child: Icon(
                      Icons.local_library,
                      color: Colors.blue,
                      size: 30,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Text(
                    date.provinceName +
                        ' ' +
                        date.cityName +
                        ' ' +
                        date.adName +
                        ' ' +
                        date.title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Visibility(
                visible: isSelected,
                child: const Icon(Icons.done, color: Colors.blue),
              ),
              GestureDetector(
                  onTap: onMore, child: Icon(Icons.more_vert, color: Colors.blue))
            ],
          ),
        ),
      ),
    );
  }
}
