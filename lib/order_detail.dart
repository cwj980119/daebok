import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'connection.dart';

class OrderDetail extends StatelessWidget {
  OrderDetail({Key? key, required this.item}) : super(key: key);

  late DocumentSnapshot item;

  @override
  Widget build(BuildContext context) {
    Connect connection = Connect();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          '주문상세',
          style: TextStyle(fontSize: 25, fontFamily: 'Hanna11'),
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
          future: connection.checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.data == Connect.NO_CONNECTION) {
              Fluttertoast.showToast(msg: "인터넷이 없습니다.");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                child: Column(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green[200],
                  child: Center(
                    child: Text(
                      '${item['customer']} 님',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Estimate')
                      .doc(item.id)
                      .collection('new')
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(snapshot.error);
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
  if (docu['kind'] == 'printnbook') return _printNBook(docu);
  if (docu['kind'] == 'bigprint') return _printNBook(docu);
  if (docu['kind'] == 'otherservice') return _printNBook(docu);
  if (docu['kind'] == 'pormboard') return _printNBook(docu);
  if (docu['kind'] == 'namecard') return _printNBook(docu);
  if (docu['kind'] == 'leaflet') return _printNBook(docu);
  if (docu['kind'] == 'sticker') return _printNBook(docu);
  if (docu['kind'] == 'envelope') return _printNBook(docu);
  ;
  if (docu['kind'] == 'banner') return _printNBook(docu);
  return Card(
    child: Container(height: 20, child: Text('1')),
  );
}

Card _printNBook(DocumentSnapshot doc) {
  return Card(
    child: Container(
      height: 20,
      child: Text('1'),
    ),
  );
}
