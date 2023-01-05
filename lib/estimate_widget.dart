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

class OrderListText extends StatelessWidget {
  OrderListText({Key? key, required this.tag, required this.value})
      : super(key: key);

  String tag;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tag}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  " : ",
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(
                    child: Text(
                  "${value}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(fontSize: 20),
                )),
              ]),
        ],
      ),
    );
  }
}

class OrderListTitle extends StatelessWidget {
  const OrderListTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
          color: Colors.green,
          border:
              Border(bottom: BorderSide(width: 1.0, style: BorderStyle.solid))),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "${title}",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderListPrice extends StatelessWidget {
  OrderListPrice({Key? key, required this.price}) : super(key: key);

  int price;
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
          border: Border(top: BorderSide()), color: Colors.green[200]),
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            "가격 : ${f.format(price)}원 ",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '프린트/제본'),
              Column(children: [
                // OrderListText(tag: '사이즈', value: map['size']),
                // OrderListText(tag: '수량', value: map['quantity']),
                // OrderListText(tag: '흑백/칼라', value: map['color']),
                // if (map['color'] == model.color_list[1])
                //   OrderListText(tag: '용지종류', value: map['paper_type']),
                // if (map['color'] == model.color_list[1])
                //   OrderListText(tag: '칼라비율', value: map['percentage']),
                // if (map['reminder'] != "")
                //   OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '대형 프린트'),
              Column(children: [
                OrderListText(tag: '사이즈', value: map['size']),
                OrderListText(tag: '수량', value: map['quantity']),
                OrderListText(tag: '흑백/칼라', value: map['color']),
                if (map['color'] == model.color_list[0])
                  OrderListText(tag: '그림 비율', value: map['black_picture']),
                if (map['color'] == model.color_list[1])
                  OrderListText(tag: '용지종류', value: map['paper_type']),
                if (map['color'] == model.color_list[1])
                  OrderListText(tag: '칼라비율', value: map['percentage']),
                OrderListText(tag: '제본', value: map['staple']),
                if (map['staple'] != '없음')
                  OrderListText(tag: '스태플 두께', value: map['thickness']),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '코팅/스캔/스태플'),
              Column(children: [
                if (map['laminate'] != 0)
                  OrderListText(tag: '코팅', value: '${map['laminate']}원'),
                if (map['scan'] != 0)
                  OrderListText(tag: '스캔', value: '${map['scan']}원'),
                if (map['staple'] != 0)
                  OrderListText(tag: '스태플', value: '${map['staple']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '폼보드'),
              Column(children: [
                OrderListText(tag: '사이즈', value: map['size']),
                OrderListText(tag: '수량', value: map['quantity']),
                OrderListText(tag: '종이 종류', value: map['paper_type']),
                if (map['paper_type'] != '켈지(코팅)')
                  OrderListText(tag: '코팅', value: map['laminate']),
                if (map['book'] != '안함')
                  OrderListText(tag: '책자폼보드', value: map['book']),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '명함'),
              Column(children: [
                OrderListText(tag: '용지', value: map['paper_type']),
                if (map['paper_type'] == '일반지')
                  OrderListText(tag: '수량', value: map['quantity']),
                if (map['paper_type'] == '수입지')
                  OrderListText(tag: '수량', value: map['si_quantity']),
                OrderListText(tag: '양/단면', value: map['side']),
                if (map['design_page'] != 0)
                  OrderListText(tag: '디자인페이지', value: '${map['design_page']}원'),
                if (map['addtional_price'] != 0)
                  OrderListText(
                      tag: '추가금액', value: '${map['addtional_price']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '리플렛'),
              Column(children: [
                OrderListText(tag: '사이즈', value: map['size']),
                if (map['paper_type'] != 'A3')
                  OrderListText(tag: '수량', value: map['quantity']),
                if (map['paper_type'] == 'A3')
                  OrderListText(tag: '수량', value: map['a3_quantity']),
                OrderListText(tag: '양/단면', value: map['side']),
                OrderListText(tag: '용지', value: map['paper_type']),
                if (map['design_page'] != 0)
                  OrderListText(tag: '디자인페이지', value: '${map['design_page']}원'),
                if (map['addtional_price'] != 0)
                  OrderListText(
                      tag: '추가금액', value: '${map['addtional_price']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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

    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
            border: Border.all(width: 3.0),
            borderRadius: BorderRadius.circular(20)),
        foregroundDecoration: BoxDecoration(
            border: Border.all(width: 3.0),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            OrderListTitle(title: '스티커'),
            Column(
              children: [
                OrderListText(tag: '종류', value: map['paper_type']),
                OrderListText(tag: '코팅', value: map['laminate']),
                OrderListText(tag: '수량', value: map['quantity']),
                OrderListText(tag: '사이즈', value: map['size']),
                if (map['design_page'] != 0)
                  OrderListText(tag: '디자인페이지', value: '${map['design_page']}원'),
                if (map['addtional_price'] != 0)
                  OrderListText(
                      tag: '추가금액', value: '${map['addtional_price']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
                OrderListPrice(price: map['price'])
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '봉투'),
              Column(children: [
                OrderListText(tag: '사이즈', value: map['size']),
                OrderListText(tag: '종류', value: map['paper_type']),
                OrderListText(tag: '수량', value: map['quantity']),
                if (map['design_page'] != 0)
                  OrderListText(tag: '디자인페이지', value: '${map['design_page']}원'),
                if (map['addtional_price'] != 0)
                  OrderListText(
                      tag: '추가금액', value: '${map['addtional_price']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
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
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              OrderListTitle(title: '배너'),
              Column(children: [
                OrderListText(tag: '용지 종류', value: map['paper_type']),
                OrderListText(tag: '거치대', value: '${map['rests']}원'),
                OrderListText(tag: '수량', value: map['quantity']),
                if (map['design_page'] != 0)
                  OrderListText(tag: '디자인페이지', value: '${map['design_page']}원'),
                if (map['addtional_price'] != 0)
                  OrderListText(
                      tag: '추가금액', value: '${map['addtional_price']}원'),
                if (map['reminder'] != "")
                  OrderListText(tag: '메모', value: map['reminder']),
              ]),
              OrderListPrice(price: map['price'])
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
