import 'package:daebok/estimate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          '대영복사',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => Estimate());
                },
                child: Text('hi'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('새로운 견적'),
        onPressed: () {
          Get.to(() => Estimate());
        },
      ),
    );
  }
}
