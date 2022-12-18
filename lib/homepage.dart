import 'package:daebok/progressing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home.dart';
import 'estimate.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          '대영복사',
          style: TextStyle(fontSize: 25, fontFamily: 'Hanna11'),
          textAlign: TextAlign.center,
        ),
      ),
      body: Get.put(NavController()).currentPage,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('새로운 견적'),
        onPressed: () {
          Get.to(() => Estimate());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: Get.put(NavController()).currentIndex.value,
        onTap: Get.put(NavController()).changePage,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '견적'),
          BottomNavigationBarItem(icon: Icon(Icons.cached), label: '진행'),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: '인쇄중'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: '완료'),
        ],
      ),
    ),
    );
  }
}

class NavController extends GetxController{
  static NavController get to => Get.find();

  final currentIndex = 0.obs;

  List<Widget> pages = [
    Home(),
    Home(),
    Home(),
    Progressing(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index){
    currentIndex.value = _index;
  }


}