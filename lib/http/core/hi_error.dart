

class NeedLogin extends HiNetError{

  NeedLogin()
  : super(code: 401,message: "请先登录");
}


class NeedAuth extends HiNetError{

  NeedAuth(String message,dynamic data)
      : super(code:403,message:message,data: data);


}


class HiNetError implements Exception{

  final int code;
  final String message;
  final dynamic data;

  HiNetError({required this.code, required this.message, this.data});

}