import 'dart:async';

import 'package:daebok/connection.dart';
import 'package:daebok/estimate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  static const routeName = '/';

  Connect connection = Connect();

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
      body: FutureBuilder(
          future: connection.checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) return CircularProgressIndicator();
            if (snapshot.data == Connect.NO_CONNECTION)
              connection.setToast('인터넷이 없습니다.');
            return Container(child: Text('${snapshot.data}'));
          }),
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
