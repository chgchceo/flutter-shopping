



import 'package:fluttershopping/http/request/base_request.dart';

class CategoryRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "index.php";
  }
}
