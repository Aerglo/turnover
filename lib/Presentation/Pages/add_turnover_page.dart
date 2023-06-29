import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:turnover/Data/Constants/contants.dart';
import 'package:turnover/Data/Controller/balance_controller.dart';
import 'package:turnover/Data/Controller/turnoverList_controller.dart';
import 'package:turnover/Data/DataBase/turnover_model.dart';
import 'package:turnover/Presentation/Constants/constants.dart';

class AddTurnover extends StatefulWidget {
  const AddTurnover({super.key});

  @override
  State<AddTurnover> createState() => _AddTurnoverState();
}

class _AddTurnoverState extends State<AddTurnover> {
  final BalanceController _balanceController = Get.put(BalanceController());
  final TurnoverListController _turnoverListController =
      Get.put(TurnoverListController());
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool deposit = true;
  String dropdownValue = Turnover.depositCategories.first;
  List<String> dropdownList = Turnover.depositCategories;
  void addTurnover(
    String title,
    String description,
    String category,
    double amount,
    bool deposit,
  ) async {
    Turnover newTurnover = Turnover(
      title: title,
      amount: amount,
      deposit: deposit,
      category: category,
      description: description,
    );
    Box<Turnover> box = await Hive.openBox<Turnover>(DataConstants.boxName);
    box.add(newTurnover);
    _balanceController.change(amount, deposit);
    _turnoverListController.change();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PresentationConstants.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: PresentationConstants.textColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Add Turnover',
          style: TextStyle(color: PresentationConstants.textColor),
        ),
        centerTitle: true,
        backgroundColor: PresentationConstants.appbarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (String? title) {
                      if (title == null) {
                        return 'Title should not be null';
                      } else if (title.isEmpty) {
                        return 'Title should not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: PresentationConstants.appbarColor,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    validator: (String? amount) {
                      if (amount == null) {
                        return 'Amount should not be null';
                      } else if (amount.isEmpty) {
                        return 'Amount should not be empty';
                      } else if (double.tryParse(amount) == null) {
                        'Amount should only contain numbers';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: PresentationConstants.appbarColor,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      hintText: 'Amount',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (String? description) {
                      if (description == null) {
                        return 'Description should not be null';
                      } else if (description.isEmpty) {
                        return 'Description should not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    maxLength: 100,
                    maxLines: 3,
                    cursorColor: PresentationConstants.appbarColor,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: PresentationConstants.appbarColor,
                        ),
                      ),
                      hintText: 'Description',
                      helperStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: deposit,
                    onChanged: (value) {
                      setState(() {
                        deposit = !deposit;
                        dropdownList = deposit
                            ? Turnover.depositCategories
                            : Turnover.spendCategories;
                        dropdownValue = deposit
                            ? Turnover.depositCategories.first
                            : Turnover.spendCategories.first;
                      });
                    },
                    activeColor: PresentationConstants.appbarColor,
                    checkColor: PresentationConstants.textColor,
                    title: const Text(
                      'Deposit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButton<String>(
                      dropdownColor: PresentationConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      value: dropdownValue,
                      icon: Icon(
                        Icons.expand_more,
                        color: PresentationConstants.appbarColor,
                      ),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: PresentationConstants.appbarColor,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: dropdownList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              value,
                              textAlign: TextAlign.end,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      gradient: deposit
                          ? LinearGradient(
                              colors: [
                                Colors.green.shade200,
                                PresentationConstants.greenColor,
                              ],
                            )
                          : LinearGradient(
                              colors: [
                                Colors.red.shade200,
                                PresentationConstants.redColor,
                              ],
                            ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          String title = _titleController.text;
                          String description = _descriptionController.text;
                          double amount = double.parse(_amountController.text);
                          String category = dropdownValue;
                          addTurnover(
                              title, description, category, amount, deposit);
                          Get.back();
                        }
                      },
                      child: Text(
                        'Add',
                        style:
                            TextStyle(color: PresentationConstants.textColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
