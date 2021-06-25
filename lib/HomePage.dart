import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/utils/LogUtil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:enote/model.dart';
import 'package:enote/sql.dart';
import 'package:enote/writePage.dart';
import './emotionCalendar/calendarConf.dart';
import 'package:get/get.dart';
import 'package:enote/controller.dart';
import 'dart:math';
import 'details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  MyPageController controller = Get.put(MyPageController());
  int currentIndex;
  CalendarController _calendarController;
  CalendarViewWidget _calendarViewWidget;
  //选中日期的列表
  HashSet<DateTime> _selectedDate = new HashSet();
  HashSet<DateModel> _selectedModels = new HashSet();
  GlobalKey<CalendarContainerState> _globalKey = new GlobalKey();
  DateModel _todayModel = DateModel.fromDateTime(DateTime.now());
  String checkDate = Model.fromDateTime(DateTime.now());
  @override
  void initState() {
    _selectedDate.add(DateTime.now());

    initList();

    //初始化日历控制器
    _calendarController = new CalendarController(
        minYear: 2021,
        minYearMonth: 1,
        maxYear: 2050,
        maxSelectMonth: 12,
        showMode: CalendarConstants.MODE_SHOW_ONLY_MONTH,
        selectedDateTimeList: _selectedDate,
        selectDateModel: _todayModel,
        selectMode: CalendarSelectedMode.singleSelect)
      //选中时监听
      ..addOnCalendarSelectListener((dateModel) async {
        _selectedModels.add(dateModel);
        checkDate = dateModel.year.toString() +
            '-' +
            dateModel.month.toString() +
            '-' +
            dateModel.day.toString();
        controller.itemList = await Sql.Query("date = '$checkDate'");
        setState(() {});
        /**如果被点击的是当天 */
        if (dateModel.isCurrentDay) {}
      })
      ..addOnCalendarUnSelectListener((dateModel) {
        LogUtil.log(
            TAG: '_selectedModels', message: _selectedModels.toString());
        LogUtil.log(TAG: 'dateModel', message: dateModel.toString());
        if (_selectedModels.contains(dateModel)) {
          _selectedModels.remove(dateModel);
        }
      });
    //初始化日历
    _calendarViewWidget = new CalendarViewWidget(
        key: _globalKey,
        calendarController: _calendarController,
        verticalSpacing: 1,
        itemSize: 130.sp,
        margin: EdgeInsets.only(left: 25.w, right: 25.w),
        dayWidgetBuilder: (DateModel model) {
          bool _isSelected = model.isSelected;
          if (_isSelected &&
              CalendarSelectedMode.singleSelect ==
                  _calendarController.calendarConfiguration.selectMode) {}
          return _isSelected
              ? getSelectedWidget(model)
              : getNormalWidget(model);
        });

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.0, end: 180.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate))
      ..addListener(() {
        setState(() {
          //print(animation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          // Get.to(ChannelDetails());
          // flag = true;
          // setState(() {});
          Get.dialog(NotePage(currentIndex)).then((value) async {
            controller.itemList = await Sql.Query("date = '$checkDate'");
            setState(() {});
          });
        }
      });
    // TODO: implement initState
    super.initState();
  }

  initList() async {
    controller.itemList = await Sql.Query("date = '$checkDate'");
    setState(() {});
  }

  //日历头部标题
  Widget calendarTitle() {
    return Container(
      height: 110.h,
      child: Row(
        children: [
          Expanded(
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _calendarController.moveToPreviousMonth();
                    controller.index.value =
                        _calendarController.getCurrentMonth().month % 12;
                  })),
          Obx(() => Text(LUNAR_MONTH_TEXT[controller.index.value])),
          Expanded(
              child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _calendarController.moveToNextMonth();
                    controller.index.value =
                        _calendarController.getCurrentMonth().month % 12;
                  }))
        ],
      ),
    );
  }

//情绪日历主体
  Widget emotionCalendar() {
    return Container(
      height: 780.h,
      child: SingleChildScrollView(
        child: _calendarViewWidget,
      ),
    );
  }

//情绪日历
  Widget _calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(45.w, 30.h, 45.w, 10.h),
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          border: Border.all(width: 1.sp),
          borderRadius: BorderRadius.circular(48.sp),
        ),
        width: ScreenUtil().screenWidth,
        // padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            calendarTitle(),
            emotionCalendar(),
          ],
        ));
  }

  Widget _card(int index) {
    return Container(
      margin: EdgeInsets.only(
          right: (index % 2 == 1) ? 45.w : 0,
          left: (index % 2 == 0) ? 45.w : 0),
      child: GestureDetector(
        onTap: () {
          currentIndex = index;
          setState(() {
            animationController.forward();
            controller.clicked.value = index;
          });
        },
        child: Transform(
          origin: Offset(239.w, 0),
          transform: Matrix4.rotationY(
              (controller.clicked.value == index ? animation.value : 0) /
                  180 *
                  pi),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2.sp, color: Colors.black54),
                borderRadius: BorderRadius.circular(28.sp)),
            child: Column(
              children: [
                Container(
                  width: 400.r,
                  height: 400.r,
                  child: controller.itemList[index]['eIndex'] > 0
                      ? Image.asset('images/' +
                          controller.itemList[index]['eIndex'].toString() +
                          '.png')
                      : Container(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Text(
                    '${controller.itemList[index]['time']}',
                    style: TextStyle(fontSize: 64.sp),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.h,
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        body: GetBuilder(
          init: controller,
          builder: (_) => Stack(
            children: [
              Positioned(
                child: Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.only(top: 100.h, bottom: 40.h),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Container(
                                child: Text(
                                  'Emotion Note',
                                  style: TextStyle(fontSize: 72.sp),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                child: Container(
                                    margin: EdgeInsets.only(right: 45.w),
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(SimpleLineIcons.note),
                                        onPressed: () {
                                          Get.dialog(WritePage()).then((_) {
                                            initList();
                                          });
                                        })),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          height: 980.h,
                          child: _calendar(),
                        )
                      ],
                    ),
                  )),
                  SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 40.w,
                      crossAxisSpacing: 40.w,
                      children: List.generate(
                        _.itemList.length,
                        (index) => _card(index),
                      )),
                  SliverPadding(padding: EdgeInsets.only(bottom: 50.h))
                ],
              )
            ],
          ),
        ));
  }
}
