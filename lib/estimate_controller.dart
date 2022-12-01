 import 'package:get/get.dart';
import 'estimate_model.dart';

class EstimateController extends GetxController{

  late PrintNBook printNBook;
  late BigPrint bigprint;
  late OtherService otherService;
  late PormBoard pormBoard;
  late OffSet offSet;

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

  toggleExpand(index){
    isExpanded[index] = !isExpanded[index];
    update();
  }

  toggleOffset(index){
    offSetExpanded[index] = !offSetExpanded[index];
    update();
  }

}

