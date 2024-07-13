

import 'dart:convert';

import 'package:fluttershopping/http/request/base_request.dart';


///网络请求抽象类
abstract class HiNetAdapter{

  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request);
}

class HiNetResponse<T>{

  T data;
  BaseRequest? request;
  int? statusCode = 200;
  String? statusMessage;
  dynamic extra;


  HiNetResponse(
  {required this.data,
     this.request,
     this.statusCode,
     this.statusMessage,
     this.extra});



  @override
  String toString() {

    if (data is Map){
      
      return json.encode(data);
    }
    return data.toString();
  }


}