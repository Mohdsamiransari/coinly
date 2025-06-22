// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class AuthModel {
  String? status;
  String? message;
  Data? authData;

  AuthModel({this.status, this.message, this.authData});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authData = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.authData != null) {
      data['data'] = this.authData!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    return data;
  }
}
