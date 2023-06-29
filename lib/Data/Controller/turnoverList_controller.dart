import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:turnover/Data/Constants/contants.dart';
import 'package:turnover/Data/DataBase/turnover_model.dart';

class TurnoverListController extends GetxController {
  Rx<List<Turnover>> turnoverList = Rx<List<Turnover>>([]);
  change() async {
    Box<Turnover> box = await Hive.openBox<Turnover>(DataConstants.boxName);
    turnoverList.value = box.values.toList();
    update();
  }
}
