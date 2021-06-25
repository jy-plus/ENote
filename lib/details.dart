import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:enote/controller.dart';
import 'package:enote/sql.dart';

class NotePage extends StatelessWidget {
  NotePage(int index, {Key key}) : super(key: key) {
    this._index = index;
  }
  int _index;
  final MyPageController controller = Get.find<MyPageController>();

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      textColor: Colors.white,
      fontSize: 38.sp,
    );
  }

  Widget _button(String title) {
    return Container(
      width: 250.w,
      height: 100.h,
      child: RaisedButton(
          padding: EdgeInsets.all(10.sp),
          elevation: 10.sp,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp),
              side: BorderSide(width: 5.sp, color: Colors.black)),
          onPressed: () async {
            if (title == '返回') {
              Get.back();
            } else if (title == '删除') {
              Get.dialog(dialog()).then((val) async {
                if (val) {
                  var res =
                      await Sql.Delete(controller.itemList[this._index]['id']);
                  toast('删除成功');
                  print(res);
                  Get.back();
                }
              });
            } else if (title == '取消') {
              Get.back(result: false);
            } else if (title == '确定') {
              Get.back(result: true);
            }
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 38.sp),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(1.0, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                  Color.fromRGBO(215, 235, 248, 1),
                  Color.fromRGBO(251, 230, 240, 1.0),
                ])),
          )),
    );
  }

  Widget dialog() {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 700.w,
            height: 380.h,
            padding: EdgeInsets.all(45.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38.sp),
                gradient: LinearGradient(
                    begin: Alignment(1.0, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                      Color.fromRGBO(215, 235, 248, 1),
                      Color.fromRGBO(251, 230, 240, 1.0),
                    ])),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '是否删除该条记录？',
                      style: TextStyle(fontSize: 48.sp),
                    ),
                  ),
                ),
                Row(
                  children: [
                    _button('取消'),
                    Expanded(
                      child: Container(),
                    ),
                    _button('确定')
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(45.sp),
          width: ScreenUtil().screenWidth / 1.3,
          height: ScreenUtil().screenHeight / 1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.sp),
              gradient: LinearGradient(
                  begin: Alignment(1.0, 0.0),
                  end: Alignment(-1.0, 0.0),
                  colors: [
                    Color.fromRGBO(215, 235, 248, 1),
                    Color.fromRGBO(251, 230, 240, 1.0),
                  ])),
          child: Column(
            children: [
              Container(
                height: ScreenUtil().screenHeight / 1.5 / 1.26,
                child: ListView(
                  children: [
                    Text(
                      controller.itemList[this._index]['content'],
                      style: TextStyle(
                          fontSize: 44.sp,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    _button('删除'),
                    Expanded(child: Container()),
                    _button('返回'),
                    Expanded(child: Container()),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
