import 'package:get/get.dart';
import 'package:enote/model.dart';

class MyPageController extends GetxController {
  //某个子项被点击的序号
  var clicked = 0.obs;
  //月份
  var index = 0.obs;

  var itemList = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    index.value = DateTime.now().month;
  }
}
