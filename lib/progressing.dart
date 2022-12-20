import 'dart:async';

import 'package:daebok/connection.dart';
import 'package:daebok/estimate.dart';
import 'package:daebok/ordercard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';

class Progressing extends StatelessWidget {
  Progressing({Key? key}) : super(key: key);
  static const routeName = '/progressing';

  Connect connection = Connect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: connection.checkConnection(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasData == false) return Center(child: Text('hi'));
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
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Estimate')
                          .orderBy('endDate', descending: false).where('status',isEqualTo: 'Progressing')
                          .snapshots(),
                      builder: (context, snapshot) {
                        final documents = snapshot.data;
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        if (documents!.docs.isEmpty)
                          return Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '내역이 없습니다.',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
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
    );
  }
}

Widget _builditem(DocumentSnapshot docu) {
  return orderCard(item: docu,level: 'Progressing',);
}