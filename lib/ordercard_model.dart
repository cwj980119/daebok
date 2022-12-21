import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daebok/Home.dart';
import 'package:daebok/homepage.dart';
import 'package:daebok/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class orderCard extends StatelessWidget {
  orderCard({Key? key, required this.item, required this.level})
      : super(key: key);

  late DocumentSnapshot item;
  String level;
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.green, width: 2.0)),
        child: Container(
          constraints: BoxConstraints(minHeight: 240),
          padding: EdgeInsets.all(20),
          height: 240,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '접수일자: ${DateFormat('yy/MM/dd').format(item['timestamp'].toDate())}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '납기: ${DateFormat('yy/MM/dd').format(item['endDate'].toDate())}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '이름: ${item['customer']}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '전화번호: ${item['phoneNumber']}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '금액: ${f.format(item['price'])}원',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '선금: ${f.format(item['prePaid'])}원',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '잔액 ${f.format(item['leftPrice'])}원',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "메모: ${item['reminder']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    if (item['leftPrice'] == 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            'PAY',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Get.to(() => OrderDetail(item: item));
                  },
                  child: Text('주문 상세'),
                ),
                leading: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    checkOrder(context, level);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print('hi');
      },
    );
  }

  void DeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "주문을 취소할경우 되돌릴 수 없습니다. 삭제하시겠습니까?",
                      style: TextStyle(fontSize: 23),
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          DeleteCheck(context);
                        },
                        child: Text(
                          "예",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "아니오",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                      ),
                    ],
                  ),
                )
              ]);
        });
  }

  void DeleteCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: FutureBuilder(
            future: delete(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return AlertDialog(
                  content: Text(
                    "주문 취소에 실패했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text(
                    "오류가 발생했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                );
              }
              return AlertDialog(
                content: Text(
                  "주문이 취소되었습니다",
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                      child: ElevatedButton(
                    child: Text('확인'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      Get.back();
                    },
                  ))
                ],
              );
              // return AlertDialog(
              //   content: Text("주문이 저장되었습니다."),
              //   actions: [
              //     Center(
              //         child: TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Text("확인")),
              //     )
              //   ],
              // );
            },
          ),
        );
      },
    );
  }

  Future delete() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> path =
          await firestore.collection(level).doc(item.id);
      print(path);
      path.delete();

      return true;

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    } catch (ex) {
      return false;
    }
  }

  void MoveDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (level == 'Estimate')
                      Text(
                        "진행 단계로 이동할까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (level == 'Progressing')
                      Text(
                        "인쇄 단계로 이동할까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (level == 'Printing')
                      Text(
                        "완료 단계로 이동할까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (level == 'Complete')
                      Text(
                        "납품 처리할까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          MoveCheck(context);
                        },
                        child: Text(
                          "예",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "아니오",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                )
              ]);
        });
  }

  void MoveBackDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (level == 'Progressing')
                      Text(
                        "견적 단계로 돌아갈까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (level == 'Printing')
                      Text(
                        "진행 단계로 돌아갈까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                    if (level == 'Complete')
                      Text(
                        "인쇄 단계로 돌아갈까요?",
                        style: TextStyle(fontSize: 23),
                      ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                          MoveBackCheck(context);
                        },
                        child: Text(
                          "예",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "아니오",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                )
              ]);
        });
  }

  void MoveCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: FutureBuilder(
            future: move(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return AlertDialog(
                  content: Text(
                    "실패했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text(
                    "오류가 발생했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                );
              }
              return AlertDialog(
                content: Text(
                  "다음단계로 이동되었습니다",
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                      child: ElevatedButton(
                    child: Text('확인'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      Get.back();
                    },
                  ))
                ],
              );
              // return AlertDialog(
              //   content: Text("주문이 저장되었습니다."),
              //   actions: [
              //     Center(
              //         child: TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Text("확인")),
              //     )
              //   ],
              // );
            },
          ),
        );
      },
    );
  }

  void MoveBackCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: FutureBuilder(
            future: moveBack(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return AlertDialog(
                  content: Text(
                    "실패했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text(
                    "오류가 발생했습니다.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                        child: ElevatedButton(
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                );
              }
              return AlertDialog(
                content: Text(
                  "다음단계로 이동되었습니다",
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                      child: ElevatedButton(
                    child: Text('확인'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      Get.back();
                    },
                  ))
                ],
              );
              // return AlertDialog(
              //   content: Text("주문이 저장되었습니다."),
              //   actions: [
              //     Center(
              //         child: TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Text("확인")),
              //     )
              //   ],
              // );
            },
          ),
        );
      },
    );
  }

  Future move() async {
    try {
      String next_level = '';
      if (level == 'Estimate') next_level = 'Progressing';
      if (level == 'Progressing') next_level = 'Printing';
      if (level == 'Printing') next_level = 'Complete';
      if (level == 'Complete') next_level = 'History';

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> fromPath =
          await firestore.collection('Estimate').doc(item.id);
      fromPath.update({'status': next_level});
      //toPath.set(item.data() as Map<String, dynamic>);
      //fromPath.delete();

      return true;

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    } catch (ex) {
      return false;
    }
  }

  Future moveBack() async {
    try {
      String next_level = '';
      if (level == 'Progressing') next_level = 'Estimate';
      if (level == 'Printing') next_level = 'Progressing';
      if (level == 'Complete') next_level = 'Printing';

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> fromPath =
          await firestore.collection('Estimate').doc(item.id);
      fromPath.update({'status': next_level});
      //toPath.set(item.data() as Map<String, dynamic>);
      //fromPath.delete();

      return true;

      //firestore.collection('Estimate').add(value);
      //firestore.collection('Estimate').doc().collection('new').add(value);
    } catch (ex) {
      return false;
    }
  }

  void checkOrder(BuildContext ctx, String level) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  if (level == 'Estimate')
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Get.back();
                              MoveDialog(ctx);
                            },
                            icon: Icon(
                              Icons.cached,
                              color: Colors.white,
                            ),
                            label: Text(
                              '진행 단계로',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Get.back();
                              DeleteDialog(ctx);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                            label: Text(
                              '주문취소',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (level == 'Progressing')
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Get.back();
                              MoveDialog(ctx);
                            },
                            icon: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                            label: Text(
                              '인쇄중으로',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.yellow[200]),
                            onPressed: () {
                              Get.back();
                              MoveBackDialog(ctx);
                            },
                            icon: Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                            label: Text(
                              '견적 단계로',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Get.back();
                              DeleteDialog(ctx);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                            label: Text(
                              '주문취소',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (level == 'Printing')
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Get.back();
                              MoveDialog(ctx);
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            label: Text(
                              '완료 단계로',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.yellow[200]),
                            onPressed: () {
                              Get.back();
                              MoveBackDialog(ctx);
                            },
                            icon: Icon(
                              Icons.cached,
                              color: Colors.black,
                            ),
                            label: Text(
                              '진행 단계로',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Get.back();
                              DeleteDialog(ctx);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                            label: Text(
                              '주문취소',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (level == 'Complete')
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Get.back();
                              MoveDialog(ctx);
                            },
                            icon: Icon(
                              Icons.handshake,
                              color: Colors.white,
                            ),
                            label: Text(
                              '전달완료',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.yellow[200]),
                            onPressed: () {
                              Get.back();
                              MoveBackDialog(ctx);
                            },
                            icon: Icon(
                              Icons.print,
                              color: Colors.black,
                            ),
                            label: Text(
                              '인쇄중으로',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Get.back();
                              DeleteDialog(ctx);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                            label: Text(
                              '주문취소',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      label: Text(
                        '닫기',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
