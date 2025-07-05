// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ExpenseModel {
  String? status;
  String? message;
  List<Data>? data;

  ExpenseModel({this.status, this.message, this.data});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
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
  String? expenseName;
  String? expenseDate;
  String? expenseNote;
  String? expenseCurrency;
  String? expenseMethod;
  String? expenseLocation;
  int? expenseAmount;
  String? expenseType;
  int? expenseCategoryId;
  ExpenseCategory? expenseCategory;
  int? userId;
  List<Splits>? splits;

  Data(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.expenseName,
      this.expenseDate,
      this.expenseNote,
      this.expenseCurrency,
      this.expenseMethod,
      this.expenseLocation,
      this.expenseAmount,
      this.expenseType,
      this.expenseCategoryId,
      this.expenseCategory,
      this.userId,
      this.splits});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    expenseName = json['expense_name'];
    expenseDate = json['expense_date'];
    expenseNote = json['expense_note'];
    expenseCurrency = json['expense_currency'];
    expenseMethod = json['expense_method'];
    expenseLocation = json['expense_location'];
    expenseAmount = json['expense_amount'];
    expenseType = json['expense_type'];
    expenseCategoryId = json['expense_category_id'];
    expenseCategory = json['expense_category'] != null
        ? new ExpenseCategory.fromJson(json['expense_category'])
        : null;
    userId = json['user_id'];
    if (json['splits'] != null) {
      splits = <Splits>[];
      json['splits'].forEach((v) {
        splits!.add(new Splits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['expense_name'] = this.expenseName;
    data['expense_date'] = this.expenseDate;
    data['expense_note'] = this.expenseNote;
    data['expense_currency'] = this.expenseCurrency;
    data['expense_method'] = this.expenseMethod;
    data['expense_location'] = this.expenseLocation;
    data['expense_amount'] = this.expenseAmount;
    data['expense_type'] = this.expenseType;
    data['expense_category_id'] = this.expenseCategoryId;
    if (this.expenseCategory != null) {
      data['expense_category'] = this.expenseCategory!.toJson();
    }
    data['user_id'] = this.userId;
    if (this.splits != null) {
      data['splits'] = this.splits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpenseCategory {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? icon;
  String? name;

  ExpenseCategory(
      {this.createdAt, this.updatedAt, this.id, this.icon, this.name});

  ExpenseCategory.fromJson(Map<String, dynamic> json) {
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

class Splits {
  int? id;
  OwedBy? owedBy;
  int? amount;
  bool? isSettled;
  Null? settledTime;

  Splits({this.id, this.owedBy, this.amount, this.isSettled, this.settledTime});

  Splits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owedBy =
        json['owed_by'] != null ? new OwedBy.fromJson(json['owed_by']) : null;
    amount = json['amount'];
    isSettled = json['is_settled'];
    settledTime = json['settled_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.owedBy != null) {
      data['owed_by'] = this.owedBy!.toJson();
    }
    data['amount'] = this.amount;
    data['is_settled'] = this.isSettled;
    data['settled_time'] = this.settledTime;
    return data;
  }
}

class OwedBy {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  Null? totalBalance;
  Null? totalDebit;
  Null? totalCredit;
  String? qrCode;
  String? hash;
  int? otp;
  String? otpExpiration;

  OwedBy(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.email,
      this.username,
      this.firstName,
      this.lastName,
      this.totalBalance,
      this.totalDebit,
      this.totalCredit,
      this.qrCode,
      this.hash,
      this.otp,
      this.otpExpiration});

  OwedBy.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    totalBalance = json['total_balance'];
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
    qrCode = json['qr_code'];
    hash = json['hash'];
    otp = json['otp'];
    otpExpiration = json['otp_expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['total_balance'] = this.totalBalance;
    data['total_debit'] = this.totalDebit;
    data['total_credit'] = this.totalCredit;
    data['qr_code'] = this.qrCode;
    data['hash'] = this.hash;
    data['otp'] = this.otp;
    data['otp_expiration'] = this.otpExpiration;
    return data;
  }
}
