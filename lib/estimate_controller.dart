import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daebok/Home.dart';
import 'package:daebok/estimate_widget.dart';
import 'package:daebok/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'estimate_model.dart';

class EstimateController extends GetxController {
  late PrintNBook printNBook;
  late BigPrint bigprint;
  late OtherService otherService;
  late PormBoard pormBoard;
  late OffSet offSet;

  String? customer = "";
  DateTime? endDate;
  String? phoneNumber = "";
  int? prePaid = 0;
  String? reminder = "";

  final phoneNumberController = TextEditingController();
  final prePaidController = TextEditingController();
  final reminderController = TextEditingController();

  setPhoneNumber(value) {
    phoneNumber = value.toString();
  }

  setPrePaidPrice(value) {
    prePaid = value;
  }

  setReminder(value) {
    reminder = value.toString();
  }

  int total_sum = 0;

  var f = NumberFormat('###,###,###,###');

  @override
  void onInit() {
    // TODO: implement onInit
    endDate = DateTime.now();

    printNBook = PrintNBook();
    bigprint = BigPrint();
    otherService = OtherService();
    pormBoard = PormBoard();
    offSet = OffSet();
    super.onInit();
  }

  RxBool isBook = false.obs;
  RxInt sum = 0.obs;

  List isExpanded = [false, false, false, false, false, true];
  List offSetExpanded = [false, false, false, false, false];

  toggleExpand(index) {
    isExpanded[index] = !isExpanded[index];
    update();
  }

  foldAll() {
    for (int i = 0; i < isExpanded.length; i++) {
      isExpanded[i] = false;
    }
    for (int i = 0; i < offSetExpanded.length; i++) {
      offSetExpanded[i] = false;
    }
    update();
  }

  toggleOffset(index) {
    offSetExpanded[index] = !offSetExpanded[index];
    update();
  }

  CalcTotal() {
    total_sum = printNBook.price +
        bigprint.price +
        otherService.price +
        pormBoard.price +
        offSet.nameCard!.price +
        offSet.leaflet!.price +
        offSet.sticker!.price +
        offSet.envelope!.price +
        offSet.banner!.price;
    offSet.calcFee();
    update();
  }

  check() {
    print(printNBook.toMap());
    print(bigprint.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['status'] = 'Estimate';
    data['customer'] = customer;
    data['endDate'] = endDate;
    data['phoneNumber'] = phoneNumber;
    data['prePaid'] = prePaid;
    data['price'] = total_sum;
    data['leftPrice'] = total_sum - prePaid!;
    data['reminder'] = reminder;
    data['timestamp'] = new DateTime.now();
    return data;
  }

  SetCustomer(value) {
    customer = value.toString();
  }

  //파이어 스토어 저장
  Future submit() async {
    try {
      if (total_sum == 0) return;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> path =
          await firestore.collection('Estimate').doc();

      firestore.doc(path.path).set(toMap());

      if (printNBook.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('printNBook')
            .set(printNBook.toMap());
      if (bigprint.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('bigprint')
            .set(bigprint.toMap());
      if (otherService.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('otherService')
            .set(otherService.toMap());
      if (pormBoard.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('pormBoard')
            .set(pormBoard.toMap());
      if (offSet.nameCard?.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('nameCard')
            .set(offSet.nameCard!.toMap());
      if (offSet.leaflet?.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('leaflet')
            .set(offSet.leaflet!.toMap());
      if (offSet.sticker?.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('sticker')
            .set(offSet.sticker!.toMap());
      if (offSet.envelope?.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('envelope')
            .set(offSet.envelope!.toMap());
      if (offSet.banner?.price != 0)
        firestore
            .doc(path.path)
            .collection('new')
            .doc('banner')
            .set(offSet.banner!.toMap());
      return true;

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    } catch (ex) {
      return false;
    }
  }

  void SubmitCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: FutureBuilder(
            future: submit(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData == false) {
                return AlertDialog(
                  content: Text(
                    "주문을 저장중입니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text(
                    "오류가 발생했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                );
              } else {
                Timer(Duration(seconds: 1), () {
                  Get.offAll(HomePage());
                });
                return AlertDialog(
                  content: Text(
                    "주문이 저장되었습니다.",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // return AlertDialog(
              //   content: Text("주문이 저장되었습니다."),
              //   actions: [
              //     Center(
              //         child: TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Text("확인")),
              //     )
              //   ],
              // );
            },
          ),
        );
      },
    );
  }

  void SubmitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          if (total_sum <= 0) {
            return AlertDialog(
              content: Text("상품이 담겨있지 않습니다"),
              actions: [
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("확인")),
                )
              ],
            );
          } else if (customer == "") {
            return AlertDialog(
              content: Text("고객명을 입력해주세요"),
              actions: [
                Center(
                  child: TextButton(
                      onPressed: () {
                        isExpanded[5] = true;
                        Navigator.of(context).pop();
                      },
                      child: Text("확인")),
                )
              ],
            );
          } else if (phoneNumber == "") {
            return AlertDialog(
              content: Text("전화번호을 입력해주세요"),
              actions: [
                Center(
                  child: TextButton(
                      onPressed: () {
                        isExpanded[5] = true;
                        Navigator.of(context).pop();
                      },
                      child: Text("확인")),
                )
              ],
            );
          }
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "주문을 접수 하시겠습니까?",
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("주문자 : ${customer}"),
                    SizedBox(
                      height: 3,
                    ),
                    Text("비용 : ${f.format(total_sum)}원"),
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
                            Navigator.of(context).pop();
                            checkOrder(context);
                          },
                          child: Text("예")),
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

  void checkOrder(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        "내역 확인",
                        style: TextStyle(fontSize: 30),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '- ${customer} 님 -',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (printNBook.price != 0)
                    PrintNBookWidget(model: printNBook),
                  if (bigprint.price != 0) BigPrintWidget(model: bigprint),
                  if (otherService.price != 0)
                    OtherServiceWidget(model: otherService),
                  if (pormBoard.price != 0) PormBoardWidget(model: pormBoard),
                  if (offSet.nameCard?.price != 0)
                    NameCardWidget(model: offSet.nameCard!),
                  if (offSet.leaflet?.price != 0)
                    LeafletWidget(model: offSet!.leaflet!),
                  if (offSet.sticker?.price != 0)
                    StickerWidget(model: offSet.sticker!),
                  if (offSet.envelope?.price != 0)
                    EnvelopeWidget(model: offSet.envelope!),
                  if (offSet.banner?.price != 0)
                    BannerWidget(model: offSet.banner!),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "총 금액 : ${f.format(total_sum)}원",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "선금 : ${f.format(prePaid)}원",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "잔액 : ${f.format(total_sum - prePaid!)}원",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SubmitCheck(context);
                    },
                    child: Text("확인"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  )
                ],
              ),
            ),
          );
        });
  }

  void connectionFail(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("인터넷 연결이 없습니다."),
            actions: [
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("확인")),
              )
            ],
          );
        });
  }
}
