import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:enote/model.dart';
import 'package:enote/sql.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key key}) : super(key: key);

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();
  bool flag = false;
  int sIndex;

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
      width: 200.w,
      height: 100.h,
      child: RaisedButton(
          padding: EdgeInsets.all(10.sp),
          elevation: 10.sp,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp),
              side: BorderSide(width: 5.sp, color: Colors.black)),
          onPressed: () async {
            if (title == 'feeling') {
              flag = !flag;
              node.unfocus();
              setState(() {});
            } else if (title == '完成') {
              if (controller.text != '') {
                Model ml = Model();
                ml.init(DateTime.now(), controller.text, sIndex);
                int i = await Sql.Insert(ml);
                print(i);
                Get.back();
              } else {
                toast('内容不能为空！');
              }
            } else if (title == '取消') {
              var res = await Sql.getInstance().then(
                  (sql) => sql.db.rawQuery("select * from ${Sql.tableName}"));
              print(res);
              Get.back();
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

  Widget _item(int index) {
    return Container(
        child: InkWell(
            child: Image.asset('images/' + index.toString() + '.png'),
            onTap: () {
              flag = false;
              sIndex = index;
              setState(() {});
              print(index);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
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
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: ScreenUtil().screenHeight / 1.5 / 1.55,
                      child: TextField(
                        focusNode: node,
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 22,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        cursorWidth: 3.5.sp,
                        style: TextStyle(
                          fontSize: 44.sp,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '碎碎念...',
                            hintStyle: TextStyle(
                                fontSize: 38.sp,
                                textBaseline: TextBaseline.alphabetic)),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: ScreenUtil().screenWidth / 1.3,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          _button('feeling'),
                          SizedBox(
                            width: 60.w,
                          ),
                          _button('完成'),
                          SizedBox(
                            width: 60.w,
                          ),
                          _button('取消')
                        ],
                      ),
                    ))
                  ],
                ),
                Positioned(
                    bottom: 150.h,
                    child: Visibility(
                        visible: flag,
                        child: Container(
                          width: ScreenUtil().screenWidth / 1.3 / 1.6,
                          height: ScreenUtil().screenHeight / 1.5 / 2.35,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: [
                              _item(1),
                              _item(2),
                              _item(3),
                              _item(4),
                              _item(5),
                              _item(6),
                              _item(7),
                              _item(8),
                              _item(9)
                            ],
                          ),
                        ))),
                Positioned(
                    bottom: 120.h,
                    right: 20.w,
                    child: Visibility(
                      child: Container(
                        child: Center(
                          child: sIndex != null && sIndex >= 1 && sIndex <= 9
                              ? Image.asset(
                                  'images/' + sIndex.toString() + '.png')
                              : Container(),
                        ),
                        width: 350.r,
                        height: 350.r,
                      ),
                      visible: !flag,
                    ))
              ],
            )),
      ),
    );
  }
}
