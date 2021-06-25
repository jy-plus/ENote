import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//点击日期弹出的对话框，可供选择情绪表情
class MyDialog extends Dialog {
  Widget _emoji(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        children: [
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
          Container(
              child: InkWell(
            child: Image.asset('images/1.png'),
            onTap: () {
              Navigator.pop(context, 'happy');
            },
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(40.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: _emoji(context),
          width: 600.w,
          height: 500.h,
        ),
      ),
      type: MaterialType.transparency,
    );
  }
}
