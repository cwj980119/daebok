import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Connect{
  static const NO_CONNECTION = 0;
  static const On_INTERNET = 1;

  Future<int> checkConnection() async{
    var result = await (Connectivity().checkConnectivity());
    if(result == ConnectivityResult.none) return Connect.NO_CONNECTION;
    else return Connect.On_INTERNET;
  }

  void setToast(message){
    Toast.show(message,duration: 1);
  }

}