import 'dart:async';

import 'package:daebok/connection.dart';
import 'package:daebok/estimate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';

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
          style: TextStyle(fontSize: 25, fontFamily: 'Hanna11'),
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
          future: connection.checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) return CircularProgressIndicator();
            if (snapshot.data == Connect.NO_CONNECTION)
              connection.setToast('인터넷이 없습니다.');
            return Container(
                child: Column(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green[200],
                  child: Center(
                      child: Text(
                    '진행중',
                    style: TextStyle(fontSize: 30),
                  )),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Estimate').orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final documents = snapshot.data;
                    print(snapshot.data);
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return Expanded(
                      child: ListView(
                        children: documents!.docs
                            .map((doc) => _builditem(doc))
                            .toList(),
                      ),
                    );
                    return Text('hi');
                  },
                ),
              ],
            ));
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

Widget _builditem(DocumentSnapshot docu) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('Estimate')
        .doc(docu.id)
        .collection('new')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();
      return Container(
        padding: EdgeInsets.all(20),
        width: 20,
        height: 200,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all()
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${snapshot.data.docs[0]['kind']}'),
              Text('가격 : ${docu['price']}'),
              Text('고객명 : ${docu['customer']}'),
              Text(
                  '접수일자 : ${DateFormat('yy년 MM월 dd일').format(docu['timestamp'].toDate())}'),
              Text('메모 : ${snapshot.data.docs[0]['reminder']}'),
            ],
          ),
        ),
      );
    },
  );
  return Container(
    width: 20,
    height: 200,
    child: Text('hi'),
  );
}
