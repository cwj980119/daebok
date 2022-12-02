import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daebok/estimate_controller.dart';
import 'package:daebok/estimate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          actions: [
            IconButton(
                onPressed: () {
                  controller.foldAll();
                },
                icon: Icon(Icons.keyboard_double_arrow_up))
          ],
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
                            '프린트 / 제본',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '사이즈',
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
                                        controller: controller
                                            .printNBook.quantityController,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '전체페이지',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        controller: controller
                                            .printNBook.totalPageController,
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
                                      '제본종류',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
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
                                      '파일종류',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '용지종류',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.printNBook.paper_type,
                                      items: controller
                                          .printNBook.paper_type_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook
                                            .setPaperType(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '양/단면',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.printNBook.side,
                                      items: controller.printNBook.side_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.printNBook.setSide(value);
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '책 두께',
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
                                      '추가금액',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: TextField(
                                        controller: controller.printNBook
                                            .additionalPriceController,
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
                              controller:
                                  controller.printNBook.reminderController,
                              onChanged: (value) {
                                controller.printNBook.setReminder(value);
                              },
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: '메모',
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
                        EstimatePrice(
                          controller: controller,
                          model: controller.printNBook,
                          modelName: '프린트/제본',
                        )
                      ],
                    ),
                  ), //Print/ Make Book
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
                            '대형 프린트',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '사이즈',
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
                                        controller: controller
                                            .bigprint.quantityController,
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
                                ), //Quantity
                              ],
                            ),
                          ),
                        ),
                        if (controller.bigprint.color ==
                            controller.bigprint.color_list[1])
                          Center(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '용지종류',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton(
                                        value: controller.bigprint.paper_type,
                                        items: controller
                                            .bigprint.paper_type_list
                                            .map((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.bigprint
                                              .setPaperType(value);
                                          controller.update();
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '칼라비율',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DropdownButton(
                                        value: controller.bigprint.percentage,
                                        items: controller
                                            .bigprint.percentage_list
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
                              controller:
                                  controller.bigprint.reminderController,
                              onChanged: (value) {
                                controller.bigprint.setReminder(value);
                              },
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: '메모',
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
                        EstimatePrice(
                          controller: controller,
                          model: controller.bigprint,
                          modelName: '대형 프린트',
                        )
                      ],
                    ),
                  ), // Big Print
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
                            '코팅/스캔/스태플',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        controller: controller
                                            .otherService.laminateController,
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
                                        controller: controller
                                            .otherService.scanController,
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
                                        controller: controller
                                            .otherService.stapleController,
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
                              controller:
                                  controller.otherService.reminderController,
                              onChanged: (value) {
                                controller.otherService.setReminder(value);
                              },
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: '메모',
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
                        EstimatePrice(
                          controller: controller,
                          model: controller.otherService,
                          modelName: '코팅/스캔/스태플',
                        )
                      ],
                    ),
                  ), //Other Service
                  ExpansionPanel(
                    //Porm Board
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[3],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            '폼보드',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '사이즈',
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
                                        controller: controller
                                            .pormBoard.quantityController,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '종이 종류',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.pormBoard.paper_type,
                                      items: controller
                                          .pormBoard.paper_type_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.pormBoard
                                            .setPaperType(value);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '코팅',
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
                                        controller.pormBoard.setLaminate(value);
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
                              controller:
                                  controller.pormBoard.reminderController,
                              onChanged: (value) {
                                controller.pormBoard.setReminder(value);
                              },
                              expands: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                labelText: '메모',
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
                        EstimatePrice(
                          controller: controller,
                          model: controller.pormBoard,
                          modelName: '폼보드',
                        )
                      ],
                    ),
                  ), //Porm Board
                  ExpansionPanel(
                      backgroundColor: Colors.green,
                      isExpanded: controller.isExpanded[4],
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return Container(
                          height: 50,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              '인쇄',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ExpansionPanelList(
                              animationDuration: Duration(milliseconds: 500),
                              children: [
                                ExpansionPanel(
                                    backgroundColor: Colors.green[200],
                                    isExpanded: controller.offSetExpanded[0],
                                    canTapOnHeader: true,
                                    headerBuilder: (context, isExpanded) {
                                      return Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            '명함',
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '용지',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller.offSet
                                                          .nameCard?.paper_type,
                                                      items: controller
                                                          .offSet
                                                          .nameCard
                                                          ?.paper_type_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setPaperType(
                                                                value);
                                                        controller.update();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '양/단면',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller.offSet
                                                          .nameCard?.side,
                                                      items: controller.offSet
                                                          .nameCard?.side_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setSide(value);
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
                                        Center(
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '수량',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .nameCard
                                                            ?.quantityController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.nameCard
                                                              ?.setQuantity(
                                                                  int.parse(
                                                                      value));
                                                          controller.update();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ), //Quantity
                                                Row(
                                                  children: [
                                                    Text(
                                                      '디자인페이지',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .nameCard
                                                            ?.designPageController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.nameCard
                                                              ?.setDesignPage(
                                                                  int.parse(
                                                                      value));
                                                          controller.update();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ), //Quantity//Quantity
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '추가금액',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .nameCard
                                                          ?.addtionalPriceController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setAdditionalPrice(
                                                                int.parse(
                                                                    value));
                                                        controller.update();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ), //Quantity
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 150,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: TextField(
                                              controller: controller.offSet
                                                  .nameCard?.reminderController,
                                              onChanged: (value) {
                                                controller.offSet.nameCard
                                                    ?.setReminder(value);
                                              },
                                              expands: true,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                labelText: '메모',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        EstimatePrice(
                                          controller: controller,
                                          model: controller.offSet.nameCard,
                                          modelName: '명함',
                                        )
                                      ],
                                    )), //NameCard
                                ExpansionPanel(
                                    backgroundColor: Colors.green[200],
                                    isExpanded: controller.offSetExpanded[1],
                                    canTapOnHeader: true,
                                    headerBuilder: (context, isExpanded) {
                                      return Container(
                                        height: 50,
                                        color: Colors.green[200],
                                        child: Center(
                                          child: Text(
                                            '리플렛',
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '사이즈',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller
                                                          .offSet.leaflet?.size,
                                                      items: controller.offSet
                                                          .leaflet?.size_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.leaflet
                                                            ?.setSize(value);
                                                        controller.update();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '양/단면',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller
                                                          .offSet.leaflet?.side,
                                                      items: controller.offSet
                                                          .leaflet?.side_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.leaflet
                                                            ?.setSide(value);
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
                                        Center(
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '수량',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .leaflet
                                                            ?.quantityController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.leaflet
                                                              ?.setQuantity(
                                                                  int.parse(
                                                                      value));
                                                          controller.update();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ), //Quantity
                                                Row(
                                                  children: [
                                                    Text(
                                                      '디자인페이지',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .leaflet
                                                            ?.designPageController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.leaflet
                                                              ?.setDesignPage(
                                                                  int.parse(
                                                                      value));
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
                                        Center(
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //Quantity
                                                Row(
                                                  children: [
                                                    Text(
                                                      '추가금액',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .leaflet
                                                            ?.addtionalPriceController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.leaflet
                                                              ?.setAdditionalPrice(
                                                                  int.parse(
                                                                      value));
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
                                              controller: controller.offSet
                                                  .leaflet?.reminderController,
                                              onChanged: (value) {
                                                controller.offSet.leaflet
                                                    ?.setReminder(value);
                                              },
                                              expands: true,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                labelText: '메모',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        EstimatePrice(
                                          controller: controller,
                                          model: controller.offSet.leaflet,
                                          modelName: '리플렛',
                                        )
                                      ],
                                    )), //Leaflet
                                ExpansionPanel(
                                    backgroundColor: Colors.green[200],
                                    isExpanded: controller.offSetExpanded[2],
                                    canTapOnHeader: true,
                                    headerBuilder: (context, isExpanded) {
                                      return Container(
                                        height: 50,
                                        color: Colors.green[200],
                                        child: Center(
                                          child: Text(
                                            '스티커',
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '종류',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller.offSet
                                                          .sticker?.paper_type,
                                                      items: controller
                                                          .offSet
                                                          .sticker
                                                          ?.paper_type_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.sticker
                                                            ?.setPaperType(
                                                                value);
                                                        controller.update();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '코팅',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller.offSet
                                                          .sticker?.laminate,
                                                      items: controller
                                                          .offSet
                                                          .sticker
                                                          ?.laminate_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.sticker
                                                            ?.setLaminate(
                                                                value);
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
                                        Center(
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '수량',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .sticker
                                                            ?.quantityController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.sticker
                                                              ?.setQuantity(
                                                                  int.parse(
                                                                      value));
                                                          controller.update();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '사이즈',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller
                                                          .offSet.sticker?.size,
                                                      items: controller.offSet
                                                          .sticker?.size_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.sticker
                                                            ?.setSize(value);
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
                                        Center(
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //Quantity
                                                Row(
                                                  children: [
                                                    Text(
                                                      '디자인페이지',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .sticker
                                                            ?.designPageController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.sticker
                                                              ?.setDesignPage(
                                                                  int.parse(
                                                                      value));
                                                          controller.update();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ), //Quantity
                                                Row(
                                                  children: [
                                                    Text(
                                                      '추가금액',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 25,
                                                      child: TextField(
                                                        controller: controller
                                                            .offSet
                                                            .sticker
                                                            ?.addtionalPriceController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  '[0-9]')),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          if (value == "")
                                                            value = "0";
                                                          controller
                                                              .offSet.sticker
                                                              ?.setAdditionalPrice(
                                                                  int.parse(
                                                                      value));
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
                                              controller: controller.offSet
                                                  .sticker?.reminderController,
                                              onChanged: (value) {
                                                controller.offSet.sticker
                                                    ?.setReminder(value);
                                              },
                                              expands: true,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                labelText: '메모',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        EstimatePrice(
                                          controller: controller,
                                          model: controller.offSet.sticker,
                                          modelName: '스티커',
                                        )
                                      ],
                                    )), //Sticker
                                ExpansionPanel(
                                  backgroundColor: Colors.green[200],
                                  isExpanded: controller.offSetExpanded[3],
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isExpanded) {
                                    return Container(
                                      height: 50,
                                      color: Colors.green[200],
                                      child: Center(
                                        child: Text(
                                          '봉투',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '사이즈',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller
                                                        .offSet.envelope?.size,
                                                    items: controller.offSet
                                                        .envelope?.size_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.envelope
                                                          ?.setSize(value);
                                                      controller.update();
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '종류',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller.offSet
                                                        .envelope?.paper_type,
                                                    items: controller
                                                        .offSet
                                                        .envelope
                                                        ?.paper_type_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.envelope
                                                          ?.setPaperType(value);
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
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '수량',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .envelope
                                                          ?.quantityController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.envelope
                                                            ?.setQuantity(
                                                                int.parse(
                                                                    value));
                                                        controller.update();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ), //Quantity
                                              Row(
                                                children: [
                                                  Text(
                                                    '디자인페이지',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .envelope
                                                          ?.designPageController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.envelope
                                                            ?.setDesignPage(
                                                                int.parse(
                                                                    value));
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
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              //Quantity
                                              Row(
                                                children: [
                                                  Text(
                                                    '추가금액',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .envelope
                                                          ?.addtionalPriceController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.envelope
                                                            ?.setAdditionalPrice(
                                                                int.parse(
                                                                    value));
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
                                            controller: controller.offSet
                                                .envelope?.reminderController,
                                            onChanged: (value) {
                                              controller.offSet.envelope
                                                  ?.setReminder(value);
                                            },
                                            expands: true,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                              labelText: '메모',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      EstimatePrice(
                                        controller: controller,
                                        model: controller.offSet.envelope,
                                        modelName: '봉투',
                                      ) //Envelope
                                    ],
                                  ),
                                ),
                                ExpansionPanel(
                                  backgroundColor: Colors.green[200],
                                  isExpanded: controller.offSetExpanded[4],
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isExpanded) {
                                    return Container(
                                      height: 50,
                                      color: Colors.green[200],
                                      child: Center(
                                        child: Text(
                                          '배너',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '용지 종류',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller.offSet
                                                        .banner?.paper_type,
                                                    items: controller.offSet
                                                        .banner?.paper_type_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.banner
                                                          ?.setPaperType(value);
                                                      controller.update();
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '거치대',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller
                                                        .offSet.banner?.rests,
                                                    items: controller.offSet
                                                        .banner?.rests_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.banner
                                                          ?.setRests(value);
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
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '수량',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .banner
                                                          ?.quantityController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller.offSet.banner
                                                            ?.setQuantity(
                                                                int.parse(
                                                                    value));
                                                        controller.update();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ), //Quantity
                                              Row(
                                                children: [
                                                  Text(
                                                    '디자인페이지',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .banner
                                                          ?.designPageController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller.offSet.banner
                                                            ?.setDesignPage(
                                                                int.parse(
                                                                    value));
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
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              //Quantity
                                              Row(
                                                children: [
                                                  Text(
                                                    '추가금액',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 25,
                                                    child: TextField(
                                                      controller: controller
                                                          .offSet
                                                          .banner
                                                          ?.addtionalPriceController,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller.offSet.banner
                                                            ?.setAdditionalPrice(
                                                                int.parse(
                                                                    value));
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
                                            controller: controller.offSet.banner
                                                ?.reminderController,
                                            onChanged: (value) {
                                              controller.offSet.banner
                                                  ?.setReminder(value);
                                            },
                                            expands: true,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                              labelText: '메모',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      EstimatePrice(
                                        controller: controller,
                                        model: controller.offSet.banner,
                                        modelName: '배너',
                                      )
                                    ],
                                  ),
                                ), //Banner
                              ],
                              expandedHeaderPadding: EdgeInsets.all(0),
                              expansionCallback: (index, isExpanded) {
                                controller.toggleOffset(index);
                              },
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '인쇄 탭 총합',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            EstimatePrice(
                              controller: controller,
                              model: controller.offSet,
                              modelName: '인쇄',
                            )
                          ],
                        ),
                      )), //Offset
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
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            StadiumBorder(),
          ),
          child: GetBuilder<EstimateController>(builder: (controller) {
            return Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        '고객명',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 50,
                        height: 25,
                        child: TextField(
                          onChanged: (value) {
                            controller.SetCustomer(value);
                            controller.update();
                          },
                        ),
                      )
                    ],
                  ),
                  Text('전체 가격 : ${controller.total_sum}'),
                  TextButton(
                    onPressed: () {
                      //controller.SubmitDialog(context);
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            // <-- SEE HERE
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      "내역 확인",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(height: 15,),
                                    if(controller.printNBook.price != 0) PrintNBookWidget(model: controller.printNBook),
                                    if(controller.bigprint.price != 0) BigPrintWidget(model: controller.bigprint),
                                    if(controller.otherService.price != 0) OtherServiceWidget(model: controller.otherService),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      '제출',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
