part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final double totalBudget;
  final double totalSpent;
  final List<double> weeklySpending;
  final Map<String, double> categorySpending;
  final List<double> monthlyTrend;
  final List<Map<String, dynamic>> topExpenses;
  final Map<String, double> categoryBudgets;

  AnalyticsLoaded({
    required this.totalBudget,
    required this.totalSpent,
    required this.weeklySpending,
    required this.categorySpending,
    required this.monthlyTrend,
    required this.topExpenses,
    required this.categoryBudgets,
  });
}
