import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/base_get_request.dart';
import 'package:fluttershopping/apis/base_post_request.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/mine/model/base_model.dart';
import 'package:fluttershopping/mine/model/image_code.dart';
import 'package:fluttershopping/mine/model/login_model.dart';
import 'package:fluttershopping/utils/sp_utils.dart';
import 'package:fluttershopping/utils/toast_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phone = "";
  var imgCode = "";
  var smsCode = "";
  var captchaKey = "";
  var base64 = "";

  @override
  void initState() {
    super.initState();

    initImgData();
  }

  initImgData() async {
    BaseGetRequest request = BaseGetRequest();

    request.add("s", "/api/captcha/image");

    var res = await HiNet.getInstance().send(request);
    ImageCodeModel model = ImageCodeModel.fromJson(jsonDecode(res.toString()));

    if (model.status == 200) {
      setState(() {
        captchaKey = model.data.key;
        var base64Str = model.data.base64;
        // 查找 "base64," 的位置
        int startIndex = base64Str.indexOf("base64,");

// 检查是否找到了 "base64,"
        if (startIndex != -1) {
          // 截取从 "base64," 之后的部分
          base64 = base64Str.substring(startIndex + "base64,".length);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: mainView(),
    );
  }

  mainView() {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Text(
              "手机号登录",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Text(
              "未注册的手机号登录后将自动注册",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        phoneView(),
        const SizedBox(
          height: 25,
        ),
        imgCodeView(),
        const SizedBox(
          height: 25,
        ),
        smsCodeView(),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            initLoginData();
          },
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.orange),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              minimumSize: WidgetStateProperty.all(const Size(350, 45))),
          child: const Text(
            "登录",
            style: TextStyle(fontSize: 19),
          ),
        )
      ],
    );
  }

  Widget smsCodeView() {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          child: TextField(
            onChanged: (v) {
              smsCode = v;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "请输入短信验证码",
                hintStyle: TextStyle(fontSize: 18)),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            if (phone.isEmpty) {
              ToastHelper.showToast("请输入手机号码");

              return;
            }
            initSmsCodeData();
          },
          child: const Text(
            "获取验证码",
            style: TextStyle(color: Colors.orange, fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 55,
        ),
      ],
    );
  }

  Widget imgCodeView() {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          child: TextField(
            onChanged: (v) {
              imgCode = v;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "请输入图形验证码",
                hintStyle: TextStyle(fontSize: 18)),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            initImgData();
          },
          child: Image.memory(
            Uint8List.fromList(base64Decode(base64)), // 网络图片URL
            fit: BoxFit.cover,
            width: 100,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              // 加载失败时显示的 Widget
              return Image.asset(
                "images/img1.png",
                fit: BoxFit.cover,
                width: 100,
                height: 40,
              );
            },
          ),
        ),
        const SizedBox(
          width: 35,
        ),
      ],
    );
  }

  Widget phoneView() {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: TextField(
            onChanged: (v) {
              phone = v;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "请输入手机号码",
                hintStyle: TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }

  void initSmsCodeData() async {
    BaseGetRequest request = BaseGetRequest();
    request.add("s", "/api/captcha/sendSmsCaptcha");
    request.add("mobile", phone);
    request.add("captchaCode", imgCode);
    request.add("captchaKey", captchaKey);

    var res = await HiNet.getInstance().send(request);

    ToastHelper.showToast(res.toString());
  }

  void initLoginData() async {
    if (phone.isEmpty) {
      ToastHelper.showToast("请输入手机号码");
      return;
    }
    if (imgCode.isEmpty) {
      ToastHelper.showToast("请输入图形验证码");
      return;
    }
    if (smsCode.isEmpty) {
      ToastHelper.showToast("请输入短信验证码");
      return;
    }
    loginSuccessAc();
    return;

    // BasePostRequest request = BasePostRequest();
    // Map<String, Object> form = {
    //   "smsCode": "246810",
    //   "mobile": "18917286702",
    //   "isParty": false,
    //   "partyData": {}
    // };

    // request.add("s", "/api/passport/login");
    // request.add("form", jsonEncode(form));

    // print(form);
    // var res = await HiNet.getInstance().send(request);
    // print(res);
    // BaseModel model1 = BaseModel.fromJson(jsonDecode(res.toString()));
    // ToastHelper.showToast(model1.message);
    // if (model1.status == 200) {
    //   LoginModel model = LoginModel.fromJson(jsonDecode(res.toString()));
    //   SPUtil.save("token", model.data?.token);
    //   SPUtil.save("userId", model.data?.userId);
    // }
  }

  void loginSuccessAc() async {
    var headers = {
      'platform': 'H5',
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://smart-shop.itheima.net/index.php?s=/api/passport/login'));
    request.body = json.encode({
      "form": {
        "smsCode": "246810",
        "mobile": "18917286702",
        "isParty": false,
        "partyData": {}
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    BaseModel model1 = BaseModel.fromJson(jsonDecode(response.toString()));
    ToastHelper.showToast(model1.message);
    if (model1.status == 200) {
      LoginModel model = LoginModel.fromJson(jsonDecode(response.toString()));
      SPUtil.save("token", model.data?.token);
      SPUtil.save("userId", model.data?.userId);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
