import 'package:daebok/estimate_controller.dart';
import 'package:daebok/estimate_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EstimatePrice extends StatelessWidget {
  EstimatePrice(
      {Key? key,
      required this.model,
      required this.controller,
      required this.modelName})
      : super(key: key);

  var f = NumberFormat('###,###,###,###');

  //final EstimateController controller;
  final dynamic model;
  final EstimateController controller;
  final String modelName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                CheckReset(context);
              },
              child: Text(
                "초기화",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
            Text(
              "가격 : ${f.format(model.price)} 원",
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }

  void CheckReset(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${modelName} 내역을 초기화 하시겠습니까?"),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          model.Reset();
                          controller.update();
                          Navigator.of(context).pop();
                        },
                        child: Text("예"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("아니오"))
                    ],
                  ),
                )
              ]);
        });
  }
}

class PrintNBookWidget extends StatelessWidget {
  const PrintNBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BigPrintWidget extends StatelessWidget {
  BigPrintWidget({Key? key, required this.model}) : super(key: key);

  final BigPrint model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Column(
          children: [
            Text(
              "대형 프린트",
              style: TextStyle(fontSize: 25),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              child: Divider(
                thickness: 2.0,
              ),
            ),
            Column(children: [
              Text("사이즈 : ${map['size']}"),
              Text("수량 : ${map['quantity']}"),
              Text("흑백/칼라 : ${map['color']}"),
              if (map['color'] == model.color_list[1])
                Text("용지종류 : ${map['paper_type']}"),
              if (map['color'] == model.color_list[1])
                Text("칼라비율 : ${map['percentage']}"),
            ]),
          ],
        ));
  }
}
