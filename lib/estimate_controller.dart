 import 'package:cloud_firestore/cloud_firestore.dart';
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

  toggleOffset(index) {
    offSetExpanded[index] = !offSetExpanded[index];
    update();
  }

  check() {
    print(printNBook.toMap());
    print(bigprint.toMap());
  }

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
    data['customer'] = customer;
    data['total_sum'] = total_sum;
    data['timestamp'] = new DateTime.now();
    return data;
  }

  submit() async {
    try {
      if(total_sum == 0) return;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> path = await firestore.collection('Estimate').doc();

      firestore.doc(path.path).set(toMap());

      if(printNBook.price != 0) firestore.doc(path.path).collection('new').doc('printNBook').set(printNBook.toMap());
      if(bigprint.price != 0) firestore.doc(path.path).collection('new').doc('bigprint').set(bigprint.toMap());
      if(otherService.price != 0) firestore.doc(path.path).collection('new').doc('otherService').set(otherService.toMap());
      if(pormBoard.price != 0) firestore.doc(path.path).collection('new').doc('pormBoard').set(pormBoard.toMap());
      if(offSet.nameCard?.price != 0) firestore.doc(path.path).collection('new').doc('nameCard').set(offSet.nameCard!.toMap());
      if(offSet.leaflet?.price != 0) firestore.doc(path.path).collection('new').doc('leaflet').set(offSet.leaflet!.toMap());
      if(offSet.sticker?.price != 0) firestore.doc(path.path).collection('new').doc('sticker').set(offSet.sticker!.toMap());
      if(offSet.envelope?.price != 0) firestore.doc(path.path).collection('new').doc('envelope').set(offSet.envelope!.toMap());
      if(offSet.banner?.price != 0) firestore.doc(path.path).collection('new').doc('banner').set(offSet.banner!.toMap());

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    }
    catch (ex) {

    }
  }
}

