// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class AuthRegisterModel {
  String? status;
  String? message;
  Data? data;

  AuthRegisterModel({this.status, this.message, this.data});

  AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? createdAt;
  String? updatedAt;
  String? totalBalance;
  String? totalDebit;
  String? totalCredit;
  String? qrCode;
  String? token;

  Data(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.updatedAt,
      this.totalBalance,
      this.totalDebit,
      this.totalCredit,
      this.qrCode, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalBalance = json['total_balance'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
    qrCode = json['qr_code'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['total_balance'] = this.totalBalance;
    data['total_debit'] = this.totalDebit;
    data['total_credit'] = this.totalCredit;
    data['qr_code'] = this.qrCode;
    data['token'] = this.token;
    return data;
  }
}
