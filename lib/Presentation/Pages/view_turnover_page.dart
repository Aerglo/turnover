import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnover/Data/DataBase/turnover_model.dart';
import 'package:turnover/Presentation/Constants/constants.dart';

class ViewTurnover extends StatefulWidget {
  final Turnover turnover;
  const ViewTurnover({super.key, required this.turnover});

  @override
  State<ViewTurnover> createState() => _ViewTurnoverState();
}

class _ViewTurnoverState extends State<ViewTurnover> {
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
        centerTitle: true,
        backgroundColor: PresentationConstants.appbarColor,
        title: Text(
          widget.turnover.title,
          style: TextStyle(color: PresentationConstants.textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: PresentationConstants.appbarColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.turnover.category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.turnover.deposit
                    ? '+${widget.turnover.amount.toString()}'
                    : '-${widget.turnover.amount.toString()}',
                style: TextStyle(
                  color: widget.turnover.deposit
                      ? PresentationConstants.greenTextColor
                      : PresentationConstants.redTextColor,
                  fontSize: 30,
                  shadows: const [
                    Shadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: PresentationConstants.appbarColor,
                    thickness: 2,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.turnover.description,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
