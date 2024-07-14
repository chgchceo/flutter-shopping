// To parse this JSON data, do
//
//     final HomeModel = HomeModelFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
HomeModel HomeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String HomeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int status;
  String message;
  Data data;

  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  PageData pageData;

  Data({
    required this.pageData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageData: PageData.fromJson(json["pageData"]),
      );

  Map<String, dynamic> toJson() => {
        "pageData": pageData.toJson(),
      };
}

class PageData {
  Page page;
  List<Item> items;

  PageData({
    required this.page,
    required this.items,
  });

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        page: Page.fromJson(json["page"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  String name;
  String type;
  ItemParams? params;
  ItemStyle style;
  List<Datum>? data;

  Item({
    required this.name,
    required this.type,
    this.params,
    required this.style,
    this.data,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        type: json["type"],
        params:
            json["params"] == null ? null : ItemParams.fromJson(json["params"]),
        style: ItemStyle.fromJson(json["style"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "params": params?.toJson(),
        "style": style.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? imgUrl;
  Link? link;
  String? imgName;
  String? text;
  int? goodsId;
  String? goodsName;
  String? sellingPoint;
  String? goodsImage;
  String? goodsPriceMin;
  String? goodsPriceMax;
  String? linePriceMin;
  String? linePriceMax;
  int? goodsSales;

  Datum({
    this.imgUrl,
    this.link,
    this.imgName,
    this.text,
    this.goodsId,
    this.goodsName,
    this.sellingPoint,
    this.goodsImage,
    this.goodsPriceMin,
    this.goodsPriceMax,
    this.linePriceMin,
    this.linePriceMax,
    this.goodsSales,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        imgUrl: json["imgUrl"],
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        imgName: json["imgName"],
        text: json["text"],
        goodsId: json["goods_id"],
        goodsName: json["goods_name"],
        sellingPoint: json["selling_point"],
        goodsImage: json["goods_image"],
        goodsPriceMin: json["goods_price_min"],
        goodsPriceMax: json["goods_price_max"],
        linePriceMin: json["line_price_min"],
        linePriceMax: json["line_price_max"],
        goodsSales: json["goods_sales"],
      );

  Map<String, dynamic> toJson() => {
        "imgUrl": imgUrl,
        "link": link?.toJson(),
        "imgName": imgName,
        "text": text,
        "goods_id": goodsId,
        "goods_name": goodsName,
        "selling_point": sellingPoint,
        "goods_image": goodsImage,
        "goods_price_min": goodsPriceMin,
        "goods_price_max": goodsPriceMax,
        "line_price_min": linePriceMin,
        "line_price_max": linePriceMax,
        "goods_sales": goodsSales,
      };
}

class Link {
  String id;
  String title;
  String type;
  Param param;
  List<Form>? form;

  Link({
    required this.id,
    required this.title,
    required this.type,
    required this.param,
    this.form,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        param: Param.fromJson(json["param"]),
        form: json["form"] == null
            ? []
            : List<Form>.from(json["form"]!.map((x) => Form.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "param": param.toJson(),
        "form": form == null
            ? []
            : List<dynamic>.from(form!.map((x) => x.toJson())),
      };
}

class Form {
  String key;
  String lable;
  bool required;
  String tips;
  String value;

  Form({
    required this.key,
    required this.lable,
    required this.required,
    required this.tips,
    required this.value,
  });

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        key: json["key"],
        lable: json["lable"],
        required: json["required"],
        tips: json["tips"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "lable": lable,
        "required": required,
        "tips": tips,
        "value": value,
      };
}

class Param {
  String path;
  Query? query;
  String url;

  Param({
    required this.path,
    this.query,
    required this.url,
  });

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        path: json["path"],
        query: json["query"] == null ? null : Query.fromJson(json["query"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "query": query?.toJson(),
        "url": url,
      };
}

class Query {
  String goodsId;

  Query({
    required this.goodsId,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        goodsId: json["goodsId"],
      );

  Map<String, dynamic> toJson() => {
        "goodsId": goodsId,
      };
}

class ItemParams {
  String? placeholder;
  String? text;
  dynamic link;
  bool? showIcon;
  bool? scrollable;
  String? content;
  String? source;
  Auto? auto;

  ItemParams({
    this.placeholder,
    this.text,
    this.link,
    this.showIcon,
    this.scrollable,
    this.content,
    this.source,
    this.auto,
  });

  factory ItemParams.fromJson(Map<String, dynamic> json) => ItemParams(
        placeholder: json["placeholder"],
        text: json["text"],
        link: json["link"],
        showIcon: json["showIcon"],
        scrollable: json["scrollable"],
        content: json["content"],
        source: json["source"],
        auto: json["auto"] == null ? null : Auto.fromJson(json["auto"]),
      );

  Map<String, dynamic> toJson() => {
        "placeholder": placeholder,
        "text": text,
        "link": link,
        "showIcon": showIcon,
        "scrollable": scrollable,
        "content": content,
        "source": source,
        "auto": auto?.toJson(),
      };
}

class Auto {
  int category;
  String goodsSort;
  int showNum;

  Auto({
    required this.category,
    required this.goodsSort,
    required this.showNum,
  });

  factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        category: json["category"],
        goodsSort: json["goodsSort"],
        showNum: json["showNum"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "goodsSort": goodsSort,
        "showNum": showNum,
      };
}

class ItemStyle {
  String? textAlign;
  String? searchStyle;
  String? btnColor;
  String? btnShape;
  int? interval;
  int? paddingTop;
  String? background;
  String? textColor;
  int? rowsNum;
  int? paddingLeft;
  String? display;
  int? column;
  List<String>? show;

  ItemStyle({
    this.textAlign,
    this.searchStyle,
    this.btnColor,
    this.btnShape,
    this.interval,
    this.paddingTop,
    this.background,
    this.textColor,
    this.rowsNum,
    this.paddingLeft,
    this.display,
    this.column,
    this.show,
  });

  factory ItemStyle.fromJson(Map<String, dynamic> json) => ItemStyle(
        textAlign: json["textAlign"],
        searchStyle: json["searchStyle"],
        btnColor: json["btnColor"],
        btnShape: json["btnShape"],
        interval: json["interval"],
        paddingTop: json["paddingTop"],
        background: json["background"],
        textColor: json["textColor"],
        rowsNum: json["rowsNum"],
        paddingLeft: json["paddingLeft"],
        display: json["display"],
        column: json["column"],
        show: json["show"] == null
            ? []
            : List<String>.from(json["show"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "textAlign": textAlign,
        "searchStyle": searchStyle,
        "btnColor": btnColor,
        "btnShape": btnShape,
        "interval": interval,
        "paddingTop": paddingTop,
        "background": background,
        "textColor": textColor,
        "rowsNum": rowsNum,
        "paddingLeft": paddingLeft,
        "display": display,
        "column": column,
        "show": show == null ? [] : List<dynamic>.from(show!.map((x) => x)),
      };
}

class Page {
  String name;
  String type;
  PageParams params;
  PageStyle style;

  Page({
    required this.name,
    required this.type,
    required this.params,
    required this.style,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        name: json["name"],
        type: json["type"],
        params: PageParams.fromJson(json["params"]),
        style: PageStyle.fromJson(json["style"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "params": params.toJson(),
        "style": style.toJson(),
      };
}

class PageParams {
  String name;
  String title;
  String shareTitle;

  PageParams({
    required this.name,
    required this.title,
    required this.shareTitle,
  });

  factory PageParams.fromJson(Map<String, dynamic> json) => PageParams(
        name: json["name"],
        title: json["title"],
        shareTitle: json["shareTitle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "shareTitle": shareTitle,
      };
}

class PageStyle {
  String titleTextColor;
  String titleBackgroundColor;

  PageStyle({
    required this.titleTextColor,
    required this.titleBackgroundColor,
  });

  factory PageStyle.fromJson(Map<String, dynamic> json) => PageStyle(
        titleTextColor: json["titleTextColor"],
        titleBackgroundColor: json["titleBackgroundColor"],
      );

  Map<String, dynamic> toJson() => {
        "titleTextColor": titleTextColor,
        "titleBackgroundColor": titleBackgroundColor,
      };
}
