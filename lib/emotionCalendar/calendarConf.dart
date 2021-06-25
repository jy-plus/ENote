import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_custom_calendar/style/style.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

//月数映射
const List<String> LUNAR_MONTH_TEXT = [
  "正月",
  "二月",
  "三月",
  "四月",
  "五月",
  "六月",
  "七月",
  "八月",
  "九月",
  "十月",
  "冬月",
  "腊月",
];

//情绪表情
Map<String, Widget> emotions = {
  '': Container(),
  'happy': Icon(
    Icons.face,
    size: 100.sp,
  ),
  'sad': Icon(
    Icons.face_outlined,
    size: 100.sp,
  ),
  'angry': Icon(
    Icons.face_rounded,
    size: 100.sp,
  )
};

//未选中时的日期样式
Widget getNormalWidget(DateModel dateModel) {
  return Container(
    margin: EdgeInsets.all(2),
    child: new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //公历
            new Expanded(
                child: Container(
              child: Center(
                child: new Text(
                  dateModel.day.toString(),
                  style: dateModel.isCurrentMonth
                      ? (dateModel.isCurrentDay
                          ? TextStyle(color: Colors.red, fontSize: 22)
                          : currentMonthTextStyle)
                      : TextStyle(color: Colors.black12, fontSize: 20),
                ),
              ),
            )),

            //农历
            // new Expanded(
            //   child: Center(
            //     child: new Text(
            //       "${dateModel.lunarString}",
            //       style: lunarTextStyle,
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}

//选中时的日期样式
Widget getSelectedWidget(DateModel dateModel) {
  return Container(
    margin: EdgeInsets.all(2),
    foregroundDecoration:
        new BoxDecoration(border: Border.all(width: 2, color: Colors.blue)),
    child: new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //公历
            new Expanded(
              child: Center(
                child: new Text(
                  dateModel.day.toString(),
                  style: currentMonthTextStyle,
                ),
              ),
            ),

            //农历
            // new Expanded(
            //   child: Center(
            //     child: new Text(
            //       "${dateModel.lunarString}",
            //       style: lunarTextStyle,
            //     ),
            //   ),
            // ),
          ],
        )
      ],
    ),
  );
}
