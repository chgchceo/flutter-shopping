// To parse this JSON data, do
//
//     final SearchListModel = SearchListModelFromJson(jsonString);

import 'dart:convert';


SearchListModel searchListModelFromJson(String str) => SearchListModel.fromJson(json.decode(str));

String searchListModelToJson(SearchListModel data) => json.encode(data.toJson());

class SearchListModel {
  int status;
  String message;
  Data data;

  SearchListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchListModel.fromJson(Map<String, dynamic> json) => SearchListModel(
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
  ListClass list;

  Data({
    required this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: ListClass.fromJson(json["list"]),
      );

  Map<String, dynamic> toJson() => {
        "list": list.toJson(),
      };
}

class ListClass {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<Datum> data;

  ListClass({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int goodsSales;
  int goodsId;
  String goodsName;
  String goodsNo;
  int videoId;
  int videoCoverId;
  String sellingPoint;
  int specType;
  String goodsPriceMin;
  String goodsPriceMax;
  String linePriceMin;
  String linePriceMax;
  int stockTotal;
  int deliveryId;
  int isPointsGift;
  int isPointsDiscount;
  int isAlonePointsDiscount;
  String pointsDiscountConfig;
  int isEnableGrade;
  int isAloneGrade;
  List<dynamic> aloneGradeEquity;
  int status;
  List<GoodsImage> goodsImages;
  String goodsImage;
  bool isUserGrade;

  Datum({
    required this.goodsSales,
    required this.goodsId,
    required this.goodsName,
    required this.goodsNo,
    required this.videoId,
    required this.videoCoverId,
    required this.sellingPoint,
    required this.specType,
    required this.goodsPriceMin,
    required this.goodsPriceMax,
    required this.linePriceMin,
    required this.linePriceMax,
    required this.stockTotal,
    required this.deliveryId,
    required this.isPointsGift,
    required this.isPointsDiscount,
    required this.isAlonePointsDiscount,
    required this.pointsDiscountConfig,
    required this.isEnableGrade,
    required this.isAloneGrade,
    required this.aloneGradeEquity,
    required this.status,
    required this.goodsImages,
    required this.goodsImage,
    required this.isUserGrade,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        goodsSales: json["goods_sales"],
        goodsId: json["goods_id"],
        goodsName: json["goods_name"],
        goodsNo: json["goods_no"],
        videoId: json["video_id"],
        videoCoverId: json["video_cover_id"],
        sellingPoint: json["selling_point"],
        specType: json["spec_type"],
        goodsPriceMin: json["goods_price_min"],
        goodsPriceMax: json["goods_price_max"],
        linePriceMin: json["line_price_min"],
        linePriceMax: json["line_price_max"],
        stockTotal: json["stock_total"],
        deliveryId: json["delivery_id"],
        isPointsGift: json["is_points_gift"],
        isPointsDiscount: json["is_points_discount"],
        isAlonePointsDiscount: json["is_alone_points_discount"],
        pointsDiscountConfig: json["points_discount_config"],
        isEnableGrade: json["is_enable_grade"],
        isAloneGrade: json["is_alone_grade"],
        aloneGradeEquity:
            List<dynamic>.from(json["alone_grade_equity"].map((x) => x)),
        status: json["status"],
        goodsImages: List<GoodsImage>.from(
            json["goods_images"].map((x) => GoodsImage.fromJson(x))),
        goodsImage: json["goods_image"],
        isUserGrade: json["is_user_grade"],
      );

  Map<String, dynamic> toJson() => {
        "goods_sales": goodsSales,
        "goods_id": goodsId,
        "goods_name": goodsName,
        "goods_no": goodsNo,
        "video_id": videoId,
        "video_cover_id": videoCoverId,
        "selling_point": sellingPoint,
        "spec_type": specType,
        "goods_price_min": goodsPriceMin,
        "goods_price_max": goodsPriceMax,
        "line_price_min": linePriceMin,
        "line_price_max": linePriceMax,
        "stock_total": stockTotal,
        "delivery_id": deliveryId,
        "is_points_gift": isPointsGift,
        "is_points_discount": isPointsDiscount,
        "is_alone_points_discount": isAlonePointsDiscount,
        "points_discount_config": pointsDiscountConfig,
        "is_enable_grade": isEnableGrade,
        "is_alone_grade": isAloneGrade,
        "alone_grade_equity":
            List<dynamic>.from(aloneGradeEquity.map((x) => x)),
        "status": status,
        "goods_images": List<dynamic>.from(goodsImages.map((x) => x.toJson())),
        "goods_image": goodsImage,
        "is_user_grade": isUserGrade,
      };
}

class GoodsImage {
  int fileId;
  int groupId;
  int channel;
  String storage;
  String domain;
  int fileType;
  String fileName;
  String filePath;
  int fileSize;
  String fileExt;
  String cover;
  int uploaderId;
  int isRecycle;
  int isDelete;
  DateTime updateTime;
  String previewUrl;
  String externalUrl;

  GoodsImage({
    required this.fileId,
    required this.groupId,
    required this.channel,
    required this.storage,
    required this.domain,
    required this.fileType,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.fileExt,
    required this.cover,
    required this.uploaderId,
    required this.isRecycle,
    required this.isDelete,
    required this.updateTime,
    required this.previewUrl,
    required this.externalUrl,
  });

  factory GoodsImage.fromJson(Map<String, dynamic> json) => GoodsImage(
        fileId: json["file_id"],
        groupId: json["group_id"],
        channel: json["channel"],
        storage: json["storage"],
        domain: json["domain"],
        fileType: json["file_type"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        fileSize: json["file_size"],
        fileExt: json["file_ext"],
        cover: json["cover"],
        uploaderId: json["uploader_id"],
        isRecycle: json["is_recycle"],
        isDelete: json["is_delete"],
        updateTime: DateTime.parse(json["update_time"]),
        previewUrl: json["preview_url"],
        externalUrl: json["external_url"],
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "group_id": groupId,
        "channel": channel,
        "storage": storage,
        "domain": domain,
        "file_type": fileType,
        "file_name": fileName,
        "file_path": filePath,
        "file_size": fileSize,
        "file_ext": fileExt,
        "cover": cover,
        "uploader_id": uploaderId,
        "is_recycle": isRecycle,
        "is_delete": isDelete,
        "update_time": updateTime.toIso8601String(),
        "preview_url": previewUrl,
        "external_url": externalUrl,
      };
}
