import 'package:fluttershopping/http/core/hi_net_adapter.dart';
import 'package:fluttershopping/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request) {
    return Future<HiNetResponse>.delayed(const Duration(milliseconds: 1000),
        () {
      return HiNetResponse<dynamic>(
          data: {"code": 0, "message": "success"}, statusCode: 500);
    });
  }
}
