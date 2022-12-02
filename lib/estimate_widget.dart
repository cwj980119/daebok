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
                          controller.CalcTotal();
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
  PrintNBookWidget({Key? key, required this.model}) : super(key: key);

  final PrintNBook model;
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "프린트 / 제본",
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
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BigPrintWidget extends StatelessWidget {
  BigPrintWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final BigPrint model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
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
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OtherServiceWidget extends StatelessWidget {
  OtherServiceWidget({Key? key, required this.model}) : super(key: key);

  final OtherService model;
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "코팅/스캔/스태플",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Column(children: [
                if (map['laminate'] != 0) Text("코팅 : ${map['laminate']}"),
                if (map['scan'] != 0) Text("스캔 : ${map['scan']}"),
                if (map['staple'] != 0) Text("스태플 : ${map['staple']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PormBoardWidget extends StatelessWidget {
  PormBoardWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final PormBoard model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "폼보드",
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
                Text("종이 종류 : ${map['paper_type']}"),
                Text("코팅 : ${map['laminate']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NameCardWidget extends StatelessWidget {
  NameCardWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final NameCard model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "명함",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Column(children: [
                Text("용지 : ${map['paper_type']}"),
                Text("수량 : ${map['quantity']}"),
                Text("양/단면 : ${map['side']}"),
                if (map['design_page'] != 0)
                  Text("디자인페이지 : ${map['design_page']}"),
                if (map['additional_price'] != 0)
                  Text("추가금액 : ${map['addtional_price']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeafletWidget extends StatelessWidget {
  LeafletWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final Leaflet model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "리플렛",
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
                Text("양/단면 : ${map['side']}"),
                if (map['design_page'] != 0) Text("디자인페이지 : ${map['design_page']}"),
                if (map['addtional_price'] != 0) Text("추가금액 : ${map['addtional_price']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StickerWidget extends StatelessWidget {
  StickerWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final Sticker model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "스티커",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Column(children: [
                Text("종류 : ${map['paper_type']}"),
                Text("코팅 : ${map['laminate']}"),
                Text("수량 : ${map['quantity']}"),
                Text("사이즈 : ${map['size']}"),
                if (map['design_page'] != 0) Text("디자인페이지 : ${map['design_page']}"),
                if (map['addtional_price'] != 0)Text("추가금액 : ${map['addtional_price']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EnvelopeWidget extends StatelessWidget {
  EnvelopeWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final Envelope model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "봉투",
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
                Text("종류 : ${map['paper_type']}"),
                Text("수량 : ${map['quantity']}"),
                if (map['design_page'] != 0) Text("디자인페이지 : ${map['design_page']}"),
                if (map['addtional_price'] != 0) Text("추가금액 : ${map['addtional_price']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BannerWidget extends StatelessWidget {
  BannerWidget({Key? key, required this.model}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
  final MyBanner model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = model.toMap();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Text(
                "배너",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Column(children: [
                Text("용지 종류 : ${map['paper_type']}"),
                Text("거치대 : ${map['rests']}"),
                Text("수량 : ${map['quantity']}"),
                if (map['design_page'] != 0) Text("디자인페이지 : ${map['design_page']}"),
                if (map['addtional_price'] != 0) Text("추가금액 : ${map['addtional_price']}"),
                if (map['reminder'] != "") Text("메모 : ${map['reminder']}"),
              ]),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              Text(
                "가격 : ${f.format(map['price'])}원 ",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
