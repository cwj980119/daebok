import 'package:daebok/price_table.dart';
import 'package:daebok/printing.dart';
import 'package:daebok/progressing.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import 'Home.dart';
import 'complete.dart';
import 'estimate.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
          backgroundColor: Colors.green,
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
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Container(child:Image.asset('assets/title.jpeg', fit: BoxFit.fitWidth,), margin: EdgeInsets.all(0),padding: EdgeInsets.all(0),),
                // child: Center(
                //     child: Text(
                //   '대영복사',
                //   style: TextStyle(fontSize: 40),
                // )),
              ),
              ListTile(
                leading: Icon(Icons.image_aspect_ratio),
                title: Text(
                  '단가표',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: (){
                  Get.to(()=>PriceTable());
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.question_mark),
                title: Text(
                  '필요한 기능있으면 알려주세요',
                  style: TextStyle(fontSize: 15),
                ),
                onTap: (){
                  Fluttertoast.showToast(msg: "대영복사 화이팅~");
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  static NavController get to => Get.find();

  final currentIndex = 0.obs;

  List<Widget> pages = [
    Home(),
    Progressing(),
    Printing(),
    Complete(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int _index) {
    currentIndex.value = _index;
  }
}
