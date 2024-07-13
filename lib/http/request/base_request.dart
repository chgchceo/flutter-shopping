enum HttpMethod { GET , POST , DELETE }


abstract class BaseRequest{

  var pathParams;
  var userHttps = true;
  String authority(){

    return "smart-shop.itheima.net";
  }
  HttpMethod httpMethod();
  String path();
  String url(){
    Uri uri;
    var pathStr = path();
    if(pathParams != null){

      if(pathStr.endsWith("/")){

        pathStr = "${path()}$pathParams";
      }else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (userHttps){
      uri = Uri.https(authority(),pathStr,params);
    }else{
      uri = Uri.http(authority(),pathStr,params);
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String,String> params = Map();

  //添加参数
  BaseRequest add(String k,Object v){

    params[k] = v.toString();
    return this;
  }

  Map<String,dynamic> header = Map();
  //添加header
   BaseRequest addHeader(String k,Object v){

     header[k] = v.toString();
     return this;
   }

}