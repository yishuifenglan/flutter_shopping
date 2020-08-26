import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FStarRating extends StatefulWidget {

  final double rating;
  final double maxRating;
  final Widget unselectedImage;
  final Widget selectedImage;
  final int    count;
  final double size;
  final Color  unselectedColor;
  final Color  selectedColor;

  FStarRating({
    @required this.rating,
    this.maxRating = 10,
    this.size = 20,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffe0aa46),
    Widget unselectedImage,
    Widget selectedImage,
    this.count = 5,
  }):unselectedImage = unselectedImage ?? Icon(Icons.star,size: size,color: unselectedColor,),
        selectedImage = selectedImage ?? Icon(Icons.star,size: size,color: selectedColor,);

  @override
  _FStarRatingState createState() => _FStarRatingState();
}

class _FStarRatingState extends State<FStarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Row(children: getUnselectImage(), mainAxisSize: MainAxisSize.min,),
          Row(children: getSelectImage(), mainAxisSize: MainAxisSize.min,),
        ],
      ),
    );
  }


  List<Widget> getUnselectImage() {
    return List.generate(widget.count, (index) {
      return widget.unselectedImage;
    });
  }

  List<Widget> getSelectImage() {
    //1.计算Star个数和剩余比例等
    double oneVale = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneVale).floor();
    double leftValue = widget.rating - entireCount * oneVale;
    double leftRatio = leftValue / oneVale;

    //2.获取Star
    List<Widget> selectedImages = [];
    for (int i = 0; i < entireCount; i++) {
      selectedImages.add(widget.selectedImage);
    }

    //3.计算
    Widget leftStar = ClipRect(
      clipper: MyRectClipper(width: leftRatio*widget.size),
      child: widget.selectedImage,
    );
    selectedImages.add(leftStar);
    return selectedImages;
  }

}

class MyRectClipper extends CustomClipper<Rect> {
  final double width;

  MyRectClipper({this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(MyRectClipper oldClipper) {
    return width != oldClipper.width;
  }
}