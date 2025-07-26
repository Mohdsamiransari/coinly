class ExpenseFilterModel {
  List<String>? expenseType;
  String? sortName;
  double? amount;

  ExpenseFilterModel({this.expenseType, this.sortName, this.amount});

  ExpenseFilterModel.fromJson(Map<String, dynamic> json) {
    expenseType = json['expenseType'].cast<String>();
    sortName = json['sortName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenseType'] = this.expenseType;
    data['sortName'] = this.sortName;
    data['amount'] = this.amount;
    return data;
  }
}
