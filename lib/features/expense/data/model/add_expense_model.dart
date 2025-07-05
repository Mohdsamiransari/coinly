// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class AddExpenseModel {
  String? status;
  String? message;
  Data? data;

  AddExpenseModel({this.status, this.message, this.data});

  AddExpenseModel.fromJson(Map<String, dynamic> json) {
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
  ExpenseCategory? user;

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
      this.user});

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
    user = json['user'] != null
        ? new ExpenseCategory.fromJson(json['user'])
        : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ExpenseCategory {
  int? id;

  ExpenseCategory({this.id});

  ExpenseCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
