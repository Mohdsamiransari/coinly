import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String title;
  final String date;
  final String time;
  final double amount;
  final String expenseType;
  final String iconUrl;

  const Transaction({
    required this.title,
    required this.date,
    required this.time,
    required this.amount,
    required this.expenseType,
    required this.iconUrl,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      amount: (json['amount'] as num).toDouble(),
      expenseType: json['expenseType'] as String,
      iconUrl: json['iconUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'amount': amount,
      'expenseType': expenseType,
      'iconUrl': iconUrl,
    };
  }

  @override
  List<Object?> get props => [title, date, time, amount, expenseType, iconUrl];
} 