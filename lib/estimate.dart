import 'package:daebok/estimate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Estimate extends StatelessWidget {
  Estimate({Key? key}) : super(key: key);

  final controller = Get.put(EstimateController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            '견적서',
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
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[0],
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
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Size',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.printNBook.size,
                                      items: controller.printNBook.size_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook.setSize(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                Row(
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.printNBook
                                              .setQuantity(int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Total Page',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.printNBook
                                              .setTotalPage(int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Binding Style',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value:
                                          controller.printNBook.binding_style,
                                      items: controller
                                          .printNBook.binding_style_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook
                                            .setBookStyle(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Black/Color',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.printNBook.color,
                                      items: controller.printNBook.color_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook.setColor(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'File Type',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.printNBook.filetype,
                                      items: controller.printNBook.filetype_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook
                                            .setFileType(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Book Thickness',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value:
                                          controller.printNBook.book_thickness,
                                      items: controller
                                          .printNBook.book_thickness_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook
                                            .setThickness(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                Row(
                                  children: [
                                    Text(
                                      'add price',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.printNBook
                                              .setAdditionalPrice(
                                                  int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                controller.printNBook.reminder = value;
                              },
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: 'Reminder',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            child: Obx(() {
                              return Text('${controller.sum.value}');
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  ExpansionPanel(
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[1],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Big Print',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '크기',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.size,
                                      items: controller.bigprint.size_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint.setSize(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                Row(
                                  children: [
                                    Text(
                                      '수량',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.bigprint
                                              .setQuantity(int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '총 페이지',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.bigprint
                                              .setTotalPage(int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '흑백/칼라',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.color,
                                      items: controller.bigprint.color_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint.setColor(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Paper Type',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.paper_type,
                                      items: controller.bigprint.paper_type_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint.setPaperType(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Percentage',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.percentage,
                                      items: controller.bigprint.percentage_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint
                                            .setPercentage(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                //Quantity
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {},
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: 'Reminder',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            child: Obx(() {
                              return Text('${controller.sum.value}');
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  ExpansionPanel(
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[2],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Other Service',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '코팅',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") value = "0";
                                          controller.otherService
                                              .setLaminate(int.parse(value));
                                          controller.update();
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                                Row(
                                  children: [
                                    Text(
                                      '스캔',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") value = "0";
                                          controller.otherService
                                              .setScan(int.parse(value));
                                          controller.update();
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                                Row(
                                  children: [
                                    Text(
                                      '스태플',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") value = "0";
                                          controller.otherService
                                              .setStaple(int.parse(value));
                                          controller.update();
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {},
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: 'Reminder',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                              child: Text('${controller.otherService.price}')),
                        )
                      ],
                    ),
                  ),
                  ExpansionPanel(
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[3],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Porm Board',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '크기',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.pormBoard.size,
                                      items: controller.pormBoard.size_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.pormBoard.setSize(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                Row(
                                  children: [
                                    Text(
                                      '수량',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value == "") return;
                                          controller.pormBoard
                                              .setQuantity(int.parse(value));
                                        },
                                      ),
                                    )
                                  ],
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Paper Type',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.pormBoard.paper_type,
                                      items: controller.pormBoard.paper_type_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.pormBoard.setPaperType(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Laminate',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.pormBoard.laminate,
                                      items: controller.pormBoard.laminate_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.pormBoard
                                            .setLaminate(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ), //Size
                                //Quantity
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {},
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: 'Reminder',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            child: Obx(() {
                              return Text('${controller.sum.value}');
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (index, isExpanded) {
                  controller.toggleExpand(index);
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('전체 가격 : ${controller.total_sum}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
