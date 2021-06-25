import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:enote/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置为透明
        statusBarBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //隐藏设备上方状态栏
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return ScreenUtilInit(
      designSize: Size(1080, 2160), //设计稿长和宽
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //自定义主题__日间模式
        //theme: lightTheme,
        //自定义主题__夜间模式
        //darkTheme: darkTheme,
        //生成路由的回调函数，当导航到目标路由时，会使用这个来生成界面
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.native,
      ),
    );
  }
}
