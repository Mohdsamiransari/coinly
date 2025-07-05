// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ExpenseCategoryModel {
  String? status;
  String? message;
  List<Data>? data;

  ExpenseCategoryModel({this.status, this.message, this.data});

  ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? icon;
  String? name;

  Data({this.createdAt, this.updatedAt, this.id, this.icon, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    return data;
  }
}
