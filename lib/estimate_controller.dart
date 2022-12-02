import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'estimate_model.dart';

class EstimateController extends GetxController {
  late PrintNBook printNBook;
  late BigPrint bigprint;
  late OtherService otherService;
  late PormBoard pormBoard;
  late OffSet offSet;

  String? customer = "";
  int total_sum = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    printNBook = PrintNBook();
    bigprint = BigPrint();
    otherService = OtherService();
    pormBoard = PormBoard();
    offSet = OffSet();
    super.onInit();
  }

  RxBool isBook = false.obs;
  RxInt sum = 0.obs;

  List isExpanded = [false, false, false, false, false];
  List offSetExpanded = [false, false, false, false, false];

  toggleExpand(index) {
    isExpanded[index] = !isExpanded[index];
    update();
  }

  foldAll(){
    for(int i =0 ; i < isExpanded.length; i++){
      isExpanded[i] = false;
    }
    for(int i =0 ; i < offSetExpanded.length; i++){
      offSetExpanded[i] = false;
    }
    update();
  }

  toggleOffset(index) {
    offSetExpanded[index] = !offSetExpanded[index];
    update();
  }

  check() {
    print(printNBook.toMap());
    print(bigprint.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['customer'] = customer;
    data['total_sum'] = total_sum;
    data['timestamp'] = new DateTime.now();
    return data;
  }

  SetCustomer(value) {
    customer = value.toString();
  }

  submit() async {
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

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    } catch (ex) {
    }
  }

  void SubmitDialog(BuildContext context) {
    print("${customer}, ${total_sum}");
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          if (customer == "") {
            return AlertDialog(
              content: Text("고객명을 입력해주세요"),
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
          } else if (total_sum <= 0) {
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
          }
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("주문을 접수 하시겠습니까?"),
                    Text("주문자 : ${customer}"),
                    Text("비용 : ${total_sum}"),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: () {}, child: Text("예")),
                      TextButton(onPressed: () {}, child: Text("아니오"))
                    ],
                  ),
                )
              ]);
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
