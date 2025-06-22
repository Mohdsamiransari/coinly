// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class AmountModel {
  String? status;
  String? message;
  Data? data;

  AmountModel({this.status, this.message, this.data});

  AmountModel.fromJson(Map<String, dynamic> json) {
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
  int? totalBalance;
  int? totalCredit;
  int? totalDebit;

  Data({this.totalBalance, this.totalCredit, this.totalDebit});

  Data.fromJson(Map<String, dynamic> json) {
    totalBalance = json['total_balance'];
    totalCredit = json['total_credit'];
    totalDebit = json['total_debit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_balance'] = this.totalBalance;
    data['total_credit'] = this.totalCredit;
    data['total_debit'] = this.totalDebit;
    return data;
  }
}
