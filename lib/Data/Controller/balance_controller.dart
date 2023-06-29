import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceController extends GetxController {
  Rx<double> balance = Rx<double>(0);
  change(double amount, bool deposit) async {
    if (deposit) {
      balance.value += amount;
    } else {
      balance.value -= amount;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('Balance', balance.value);
    update();
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    balance.value = prefs.getDouble('Balance') ?? 0;
    update();
  }
}
