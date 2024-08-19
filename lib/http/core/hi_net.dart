import 'package:fluttershopping/http/core/dio_adapter.dart';
import 'package:fluttershopping/http/core/hi_error.dart';
import 'package:fluttershopping/http/core/hi_net_adapter.dart';
import 'package:fluttershopping/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    // ignore: prefer_typing_uninitialized_variables
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;

    int? status = response?.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), result);
      default:
        throw HiNetError(
            code: status ?? 0, message: result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog("url:${request.url()}");
    //使用dio来发送请求
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print("hi_net:${log.toString()}");
  }
}
