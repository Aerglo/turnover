import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:turnover/Data/Constants/contants.dart';
import 'package:turnover/Data/Controller/balance_controller.dart';
import 'package:turnover/Data/Controller/turnoverList_controller.dart';
import 'package:turnover/Data/DataBase/turnover_model.dart';
import 'package:turnover/Presentation/Constants/constants.dart';
import 'package:turnover/Presentation/Pages/view_turnover_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TurnoverListController _turnoverListController =
      Get.put(TurnoverListController());
  // ignore: unused_field
  final BalanceController _balanceController = Get.put(BalanceController());

  @override
  void initState() {
    _turnoverListController.change();
    _balanceController.change(-20000, true);
    _balanceController.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresentationConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: PresentationConstants.textColor),
        ),
        centerTitle: true,
        backgroundColor: PresentationConstants.appbarColor,
      ),
      body: GetX<TurnoverListController>(
        builder: (controller) {
          if (controller.turnoverList.value.isEmpty) {
            return Column(
              children: [
                GetX<BalanceController>(
                  builder: (controller) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Center(
                        child: Text(
                          _balanceController.balance.value >= 0
                              ? '+${_balanceController.balance.value}'
                              : '${_balanceController.balance.value}',
                          style: TextStyle(
                            fontSize: 40,
                            color: _balanceController.balance.value >= 0
                                ? PresentationConstants.greenColor
                                : PresentationConstants.redColor,
                            shadows: const [
                              Shadow(
                                offset: Offset(0.0, 3.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Text(
                      'Turnover list is empty:(',
                      style: TextStyle(
                        color: PresentationConstants.greyColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GetX<BalanceController>(
                    builder: (controller) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Center(
                          child: Text(
                            _balanceController.balance.value >= 0
                                ? '+${_balanceController.balance.value}'
                                : '${_balanceController.balance.value}',
                            style: TextStyle(
                              fontSize: 40,
                              color: _balanceController.balance.value >= 0
                                  ? PresentationConstants.greenColor
                                  : PresentationConstants.redColor,
                              shadows: const [
                                Shadow(
                                  offset: Offset(0.0, 3.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount:
                          _turnoverListController.turnoverList.value.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              ViewTurnover(
                                turnover: _turnoverListController
                                    .turnoverList.value[index],
                              ),
                            );
                          },
                          child: CardWidget(
                            turnoverList:
                                _turnoverListController.turnoverList.value,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PresentationConstants.appbarColor,
        onPressed: () {
          Get.toNamed('/addTurnover');
        },
        child: Icon(
          Icons.add,
          color: PresentationConstants.textColor,
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final List<Turnover> turnoverList;
  final int index;
  const CardWidget({
    super.key,
    required this.turnoverList,
    required this.index,
  });
  void deleteTurnover(int index, Turnover turnover) async {
    final TurnoverListController _turnoverListController =
        Get.put(TurnoverListController());
    // ignore: unused_field
    final BalanceController _balanceController = Get.put(BalanceController());
    Box<Turnover> box = await Hive.openBox(DataConstants.boxName);
    box.deleteAt(index);
    _turnoverListController.change();
    _balanceController.change(turnover.amount, !turnover.deposit);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Card(
        color: PresentationConstants.greyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: SizedBox(
          height: 70,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: turnoverList[index].deposit
                        ? LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              PresentationConstants.greyColor,
                              PresentationConstants.greenColor
                                  .withOpacity(0.15),
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              PresentationConstants.greyColor,
                              PresentationConstants.redColor.withOpacity(0.15),
                            ],
                          ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                    ),
                  ),
                ),
              ),
              ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: PresentationConstants.backgroundColor,
                  ),
                  onPressed: () {
                    deleteTurnover(index, turnoverList[index]);
                  },
                ),
                subtitle: Text(
                  turnoverList[index].deposit
                      ? '+${turnoverList[index].amount}'
                      : '-${turnoverList[index].amount}',
                  style: TextStyle(
                    color: turnoverList[index].deposit
                        ? PresentationConstants.greenTextColor
                        : PresentationConstants.redTextColor,
                  ),
                ),
                title: Text(
                  turnoverList[index].title,
                  style: TextStyle(
                    color: PresentationConstants.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
