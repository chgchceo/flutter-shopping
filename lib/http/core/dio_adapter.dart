import 'package:dio/dio.dart';
import 'package:fluttershopping/http/core/hi_error.dart';
import 'package:fluttershopping/http/core/hi_net_adapter.dart';
import 'package:fluttershopping/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send<T>(BaseRequest request) async {
    // ignore: prefer_typing_uninitialized_variables
    var response, options = Options(headers: request.header);
    DioException? error;

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    } 
    
    if (error != null) {
      throw HiNetError(
          code: response.statusCode,
          message: error.toString(),
          data: buildRes(response, request));
    }

    return buildRes(response, request);
  }

  HiNetResponse buildRes(Response response, BaseRequest request) {
    return HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
