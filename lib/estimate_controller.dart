 import 'package:get/get.dart';

class EstimateController extends GetxController{

  RxBool isBook = false.obs;
  List size_list = ['A4,B5','A3,B4','A4,B5(색지)','A3,B4(색지)','A4,B5(클린지)','A3,B4(클린지)'];
  late String size = size_list[0];

  List quantity_list = [];
  int quantity = 0;

  bool isExpanded = true;

  toggleExpand(){
    isExpanded = !isExpanded;
    update();
  }

  setSize(value){
    size = value.toString();
    update();
  }

  setQuantity(value){
    quantity = value;
  }

}
