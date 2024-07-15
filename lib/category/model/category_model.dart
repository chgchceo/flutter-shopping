// To parse this JSON data, do
//
//     final CategoryModel = CategoryModelFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
CategoryModel CategoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String CategoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    int status;
    String message;
    Data data;

    CategoryModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
    List<ListElement> list;

    Data({
        required this.list,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}

class ListElement {
    int categoryId;
    String name;
    int parentId;
    int imageId;
    int status;
    int sort;
    List<ListElement>? children;
    ImageModel? image;

    ListElement({
        required this.categoryId,
        required this.name,
        required this.parentId,
        required this.imageId,
        required this.status,
        required this.sort,
        this.children,
        required this.image,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        categoryId: json["category_id"],
        name: json["name"],
        parentId: json["parent_id"],
        imageId: json["image_id"],
        status: json["status"],
        sort: json["sort"],
        children: json["children"] == null ? [] : List<ListElement>.from(json["children"]!.map((x) => ListElement.fromJson(x))),
        image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "name": name,
        "parent_id": parentId,
        "image_id": imageId,
        "status": status,
        "sort": sort,
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
        "image": image?.toJson(),
    };
}

class ImageModel {
    int fileId;
    int groupId;
    int channel;
    Storage storage;
    String domain;
    int fileType;
    String fileName;
    String filePath;
    int fileSize;
    FileExt fileExt;
    String cover;
    int uploaderId;
    int isRecycle;
    int isDelete;
    DateTime updateTime;
    String previewUrl;
    String externalUrl;

    ImageModel({
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

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        fileId: json["file_id"],
        groupId: json["group_id"],
        channel: json["channel"],
        storage: storageValues.map[json["storage"]]!,
        domain: json["domain"],
        fileType: json["file_type"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        fileSize: json["file_size"],
        fileExt: fileExtValues.map[json["file_ext"]]!,
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
        "storage": storageValues.reverse[storage],
        "domain": domain,
        "file_type": fileType,
        "file_name": fileName,
        "file_path": filePath,
        "file_size": fileSize,
        "file_ext": fileExtValues.reverse[fileExt],
        "cover": cover,
        "uploader_id": uploaderId,
        "is_recycle": isRecycle,
        "is_delete": isDelete,
        "update_time": updateTime.toIso8601String(),
        "preview_url": previewUrl,
        "external_url": externalUrl,
    };
}

enum FileExt {
    JPG,
    PNG
}

final fileExtValues = EnumValues({
    "jpg": FileExt.JPG,
    "png": FileExt.PNG
});

enum Storage {
    LOCAL
}

final storageValues = EnumValues({
    "local": Storage.LOCAL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
