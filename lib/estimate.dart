import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daebok/estimate_controller.dart';
import 'package:daebok/estimate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Estimate extends StatelessWidget {
  Estimate({Key? key}) : super(key: key);

  var f = NumberFormat('###,###,###,###');
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
            style: TextStyle(fontSize: 25, fontFamily: 'Hanna11'),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh),
              color: Colors.yellow,
            ),
            IconButton(
                onPressed: () {
                  controller.foldAll();
                },
                icon: Icon(Icons.keyboard_double_arrow_up)),
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
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      );
                    },
                    body: Container(
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '수량',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
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
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '전체페이지',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
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
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.printNBook.setFileType(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.printNBook.color == '칼라 레이져')
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
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
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '제본종류',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton(
                                    value: controller.printNBook.binding_style,
                                    items: controller
                                        .printNBook.binding_style_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.printNBook.setBookStyle(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '책 두께',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton(
                                    value: controller.printNBook.book_thickness,
                                    items: controller
                                        .printNBook.book_thickness_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.printNBook.setThickness(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '추가금액',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 25,
                                    child: TextField(
                                      controller: controller
                                          .printNBook.additionalPriceController,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      );
                    },
                    body: Container(
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '수량',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
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
                                        controller.CalcTotal();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.bigprint.color ==
                              controller.bigprint.color_list[0])
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
                                  children: [
                                    Text(
                                      '그림비율',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.black_picture,
                                      items: controller
                                          .bigprint.black_picture_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint
                                            .setBlackPicture(value);
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (controller.bigprint.color ==
                              controller.bigprint.color_list[1])
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
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
                                      items: controller.bigprint.paper_type_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint.setPaperType(value);
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (controller.bigprint.color ==
                              controller.bigprint.color_list[1])
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
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
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '제본',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton(
                                    value: controller.bigprint.staple,
                                    items: controller.bigprint.staple_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.bigprint.setStaple(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.bigprint.staple !=
                              controller.bigprint.staple_list[0])
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
                                  children: [
                                    Text(
                                      '제본',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton(
                                      value: controller.bigprint.thickness,
                                      items: controller.bigprint.thickness_list
                                          .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bigprint.setThickness(value);
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ), //Size
                          //Quantity
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                            style: TextStyle(fontSize: 25, color: Colors.white),
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
                                      width: 70,
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
                                          controller.CalcTotal();
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
                                      width: 70,
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
                                          controller.CalcTotal();
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
                                      width: 70,
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
                                          controller.CalcTotal();
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
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      );
                    },
                    body: Container(
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '보드 종류',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton(
                                    value: controller.pormBoard.board_type,
                                    items: controller.pormBoard.board_type_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.pormBoard.setBoardType(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '*하드보드는 A3까지',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ), //Size
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '수량',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
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
                                        controller.CalcTotal();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
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
                                    items: controller.pormBoard.paper_type_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.pormBoard.setPaperType(value);
                                      controller.CalcTotal();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.pormBoard.paper_type != '켈지(코팅)')
                            UnconstrainedBox(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
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
                                        controller.CalcTotal();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '책자폼보드',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton(
                                    value: controller.pormBoard.book,
                                    items: controller.pormBoard.book_list
                                        .map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.pormBoard.setBook(value);
                                      controller.CalcTotal();
                                    },
                                  ),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
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
                                    body: Container(
                                      color: Colors.white,
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceAround,
                                        children: [
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '용지',
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                                      controller.offSet.nameCard
                                                          ?.setPaperType(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '양/단면',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller
                                                        .offSet.nameCard?.side,
                                                    items: controller.offSet
                                                        .nameCard?.side_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.nameCard
                                                          ?.setSide(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (controller.offSet.nameCard!
                                                  .paper_type ==
                                              '일반지')
                                            UnconstrainedBox(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                height: 70,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '수량',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller.offSet
                                                          .nameCard?.quantity,
                                                      items: controller
                                                          .offSet
                                                          .nameCard
                                                          ?.quantity_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setQuantity(
                                                                value);
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ), //Quantity
                                          if (controller.offSet.nameCard!
                                                  .paper_type ==
                                              '수입지')
                                            UnconstrainedBox(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                height: 70,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '수량',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    DropdownButton(
                                                      value: controller
                                                          .offSet
                                                          .nameCard
                                                          ?.si_quantity,
                                                      items: controller
                                                          .offSet
                                                          .nameCard
                                                          ?.si_quantity_list
                                                          .map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setSiQuantity(
                                                                value);
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ), //Quantity
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.nameCard
                                                            ?.setDesignPage(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
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
                                                controller: controller
                                                    .offSet
                                                    .nameCard
                                                    ?.reminderController,
                                                onChanged: (value) {
                                                  controller.offSet.nameCard
                                                      ?.setReminder(value);
                                                },
                                                expands: true,
                                                maxLines: null,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: '메모',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                      ),
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
                                    body: Container(
                                      color: Colors.white,
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceAround,
                                        children: [
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                      controller.offSet.leaflet
                                                          ?.setSize(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '양/단면',
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                                      controller.offSet.leaflet
                                                          ?.setSide(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.leaflet
                                                            ?.setQuantity(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ), //Quantity
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.leaflet
                                                            ?.setDesignPage(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.leaflet
                                                            ?.setAdditionalPrice(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
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
                                                controller: controller
                                                    .offSet
                                                    .leaflet
                                                    ?.reminderController,
                                                onChanged: (value) {
                                                  controller.offSet.leaflet
                                                      ?.setReminder(value);
                                                },
                                                expands: true,
                                                maxLines: null,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: '메모',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                      ),
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
                                    body: Container(
                                      color: Colors.white,
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceAround,
                                        children: [
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                      controller.offSet.sticker
                                                          ?.setPaperType(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '코팅',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  DropdownButton(
                                                    value: controller.offSet
                                                        .sticker?.laminate,
                                                    items: controller.offSet
                                                        .sticker?.laminate_list
                                                        .map((value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.offSet.sticker
                                                          ?.setLaminate(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.sticker
                                                            ?.setQuantity(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                      controller.offSet.sticker
                                                          ?.setSize(value);
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.sticker
                                                            ?.setDesignPage(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ), //Quantity
                                          UnconstrainedBox(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 70,
                                              child: Row(
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
                                                    width: 70,
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
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value == "")
                                                          value = "0";
                                                        controller
                                                            .offSet.sticker
                                                            ?.setAdditionalPrice(
                                                                int.parse(
                                                                    value));
                                                        controller.CalcTotal();
                                                      },
                                                    ),
                                                  )
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
                                                controller: controller
                                                    .offSet
                                                    .sticker
                                                    ?.reminderController,
                                                onChanged: (value) {
                                                  controller.offSet.sticker
                                                      ?.setReminder(value);
                                                },
                                                expands: true,
                                                maxLines: null,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: '메모',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                      ),
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
                                  body: Container(
                                    color: Colors.white,
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceAround,
                                      children: [
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (controller.offSet.envelope!
                                            .size ==
                                            '소')
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  items: controller.offSet
                                                      .envelope?.paper_type_list
                                                      .map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller.offSet.envelope
                                                        ?.setPaperType(value);
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (controller.offSet.envelope!
                                            .size ==
                                            '대')
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                      .envelope?.big_paper_type,
                                                  items: controller.offSet
                                                      .envelope?.big_paper_type_list
                                                      .map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller.offSet.envelope
                                                        ?.setBigPaperType(value);
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
                                              children: [
                                                Text(
                                                  '흑백/칼라',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                DropdownButton(
                                                  value: controller.offSet
                                                      .envelope?.color,
                                                  items: controller.offSet
                                                      .envelope?.color_list
                                                      .map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller.offSet.envelope
                                                        ?.setColor(value);
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .envelope
                                                        ?.quantityController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.envelope
                                                          ?.setQuantity(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(child: Text('수량 단위 소봉투 1000장, 대봉투 흑백 1000장, 칼라 500장', style: TextStyle(color: Colors.grey),),),//Quantity
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .envelope
                                                        ?.designPageController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.envelope
                                                          ?.setDesignPage(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .envelope
                                                        ?.addtionalPriceController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.envelope
                                                          ?.setAdditionalPrice(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(child: Text('자켓소봉투 +20,000원', style: TextStyle(color: Colors.grey),),),//Quantity
                                        UnconstrainedBox(child: Text('양면테이프 +30,000원', style: TextStyle(color: Colors.grey),),),//Quantity

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
                                          model: controller.offSet.envelope,
                                          modelName: '봉투',
                                        ) //Envelope
                                      ],
                                    ),
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
                                  body: Container(
                                    color: Colors.white,
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceAround,
                                      children: [
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  items: controller
                                                      .offSet.banner?.rests_list
                                                      .map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller.offSet.banner
                                                        ?.setRests(value);
                                                    controller.CalcTotal();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .banner
                                                        ?.quantityController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.banner
                                                          ?.setQuantity(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ), //Quantity
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .banner
                                                        ?.designPageController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.banner
                                                          ?.setDesignPage(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        UnconstrainedBox(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            child: Row(
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
                                                  width: 70,
                                                  height: 25,
                                                  child: TextField(
                                                    controller: controller
                                                        .offSet
                                                        .banner
                                                        ?.addtionalPriceController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value == "")
                                                        value = "0";
                                                      controller.offSet.banner
                                                          ?.setAdditionalPrice(
                                                              int.parse(value));
                                                      controller.CalcTotal();
                                                    },
                                                  ),
                                                )
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
                                              keyboardType:
                                                  TextInputType.multiline,
                                              controller: controller.offSet
                                                  .banner?.reminderController,
                                              onChanged: (value) {
                                                controller.offSet.banner
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
                                          model: controller.offSet.banner,
                                          modelName: '배너',
                                        )
                                      ],
                                    ),
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
                  ExpansionPanel(
                    backgroundColor: Colors.green,
                    isExpanded: controller.isExpanded[5],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 50,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            '고객정보',
                            style: TextStyle(fontSize: 25, color: Colors.yellow),
                          ),
                        ),
                      );
                    },
                    body: Container(
                      color: Colors.white,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '고객명',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 25,
                                    child: TextField(
                                      onChanged: (value) {
                                        controller.SetCustomer(value);
                                        controller.CalcTotal();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: GetBuilder<EstimateController>(
                                builder: (controller) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
                                  children: [
                                    Text(
                                      '납기일',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(DateFormat('yyyy/MM/dd')
                                        .format(controller.endDate!)
                                        .toString()),
                                    SizedBox(width: 10,),
                                    SizedBox(
                                        height: 25,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2030))
                                                .then((value) =>
                                                    controller.endDate = value)
                                                .then((value) =>
                                                    controller.update());
                                          },
                                          child: Center(
                                              child: Icon(Icons.date_range)),
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.green),
                                        ))
                                  ],
                                ),
                              );
                            }),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '전화번호',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 25,
                                    child: TextField(
                                      controller: controller
                                          .phoneNumberController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value == "") return;
                                        controller
                                            .setPhoneNumber(value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: [
                                  Text(
                                    '선금',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 25,
                                    child: TextField(
                                      controller: controller
                                          .prePaidController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value == "") return;
                                        controller
                                            .setPrePaidPrice(
                                            int.parse(value));
                                      },
                                    ),
                                  )
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
                                    controller.reminderController,
                                onChanged: (value) {
                                  controller.setReminder(value);
                                },
                                expands: true,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  labelText: '메모',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  Text(
                    '전체 가격 : ${f.format(controller.total_sum)}원',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.CalcTotal();
                      // if(controller.total_sum!=0) {
                      //   showModalBottomSheet(
                      //     context: context,
                      //     shape: const RoundedRectangleBorder(
                      //       // <-- SEE HERE
                      //       borderRadius: BorderRadius.vertical(
                      //         top: Radius.circular(25.0),
                      //       ),
                      //     ),
                      //     builder: (context) {
                      //       return SingleChildScrollView(
                      //         child: Container(
                      //           child: Column(
                      //             children: [
                      //               SizedBox(height: 10,),
                      //               Text(
                      //                 "내역 확인",
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //               SizedBox(height: 15,),
                      //               if(controller.printNBook.price != 0) PrintNBookWidget(model: controller.printNBook),
                      //               if(controller.bigprint.price != 0) BigPrintWidget(model: controller.bigprint),
                      //               if(controller.otherService.price != 0) OtherServiceWidget(model: controller.otherService),
                      //               if(controller.pormBoard.price != 0) PormBoardWidget(model: controller.pormBoard),
                      //               if(controller.offSet.nameCard?.price != 0) NameCardWidget(model: controller.offSet.nameCard!),
                      //               if(controller.offSet.leaflet?.price != 0) LeafletWidget(model: controller.offSet!.leaflet!),
                      //               if(controller.offSet.sticker?.price != 0) StickerWidget(model: controller.offSet.sticker!),
                      //               if(controller.offSet.envelope?.price != 0) EnvelopeWidget(model: controller.offSet.envelope!),
                      //               if(controller.offSet.banner?.price != 0) BannerWidget(model: controller.offSet.banner!),
                      //               SizedBox(height: 10,),
                      //               Text(
                      //                 "총 금액 : ${f.format(controller.total_sum)}원",
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //               SizedBox(height: 15,),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     });
                      // }
                      controller.SubmitDialog(context);
                    },
                    child: Text(
                      '제출',
                      style: TextStyle(color: Colors.white),
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
