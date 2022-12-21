import 'package:flutter/material.dart';

class PriceTable extends StatelessWidget {
  const PriceTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          '단가표',
          style: TextStyle(fontSize: 25, fontFamily: 'Hanna11'),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: InteractiveViewer(
          child: Column(
            children: [
              Image.asset('assets/table1.jpeg'),
              Image.asset('assets/table2.jpeg')
            ],
          ),
        ),
      ),
    );
  }
}
