import 'package:get/get.dart';
import 'package:enote/HomePage.dart';

class AppPages {
  static const INITIAL = '/';
  static const HOME = '/Home';
  static final routes = [
    //启动页面
    GetPage(name: '/', page: () => HomePage()),
  ];
}
