import 'package:daebok/estimate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Estimate extends StatelessWidget {
  Estimate({Key? key}) : super(key: key);

  final controller = Get.put(EstimateController());

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
      body: SingleChildScrollView(
        child: GetBuilder<EstimateController>(
          builder: (controller) {
            return ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              children: [
                ExpansionPanel(
                    isExpanded: controller.isExpanded,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Print / Make Book',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Size',
                                  style: TextStyle(fontSize: 20),
                                ),
                                DropdownButton(
                                  value: controller.size,
                                  items: controller.size_list.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.setSize(value);
                                  },
                                ),
                                Text(
                                  'Quantity',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value == "") return;
                                      controller.setQuantity(int.parse(value));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
              ],
              expandedHeaderPadding: EdgeInsets.all(0),
              expansionCallback: (index, isExpanded) {
                controller.toggleExpand();
              },
            );
          },
        ),
      ),
    );
  }
}
