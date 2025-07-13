import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  // Store the original dummy data for filtering
  final List<double> _originalMonthlyTrend = [1200, 1500, 1100, 1700, 1250, 1400];
  final List<Map<String, dynamic>> _originalTopExpenses = [
    {'name': 'MacBook Purchase', 'amount': 800, 'date': '2024-06-01', 'category': 'Shopping', 'month': 5},
    {'name': 'Groceries', 'amount': 200, 'date': '2024-06-03', 'category': 'Food', 'month': 5},
    {'name': 'Flight Ticket', 'amount': 150, 'date': '2024-06-05', 'category': 'Transport', 'month': 5},
    {'name': 'Movie', 'amount': 100, 'date': '2024-05-10', 'category': 'Entertainment', 'month': 4},
    {'name': 'Electricity Bill', 'amount': 120, 'date': '2024-04-15', 'category': 'Bills', 'month': 3},
  ];
  final Map<String, double> _originalCategorySpending = {
    'Food': 400,
    'Transport': 200,
    'Entertainment': 150,
    'Shopping': 300,
    'Bills': 200,
  };
  final Map<String, double> _originalCategoryBudgets = {
    'Food': 500,
    'Transport': 300,
    'Entertainment': 200,
    'Shopping': 400,
    'Bills': 300,
  };

  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<LoadAnalyticsEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AnalyticsLoaded(
        totalBudget: 2000.0,
        totalSpent: 1250.0,
        weeklySpending: [200, 150, 300, 100, 250, 150, 100],
        categorySpending: Map.from(_originalCategorySpending),
        monthlyTrend: List.from(_originalMonthlyTrend),
        topExpenses: List.from(_originalTopExpenses),
        categoryBudgets: Map.from(_originalCategoryBudgets),
      ));
    });
    on<FilterAnalyticsEvent>((event, emit) async {
      // Filter top expenses
      List<Map<String, dynamic>> filteredExpenses = _originalTopExpenses;
      if (event.monthIndex != null) {
        filteredExpenses = filteredExpenses.where((e) => e['month'] == event.monthIndex).toList();
      }
      if (event.category != null && event.category!.isNotEmpty) {
        filteredExpenses = filteredExpenses.where((e) => e['category'] == event.category).toList();
      }
      if (event.minPrice != null) {
        filteredExpenses = filteredExpenses.where((e) => (e['amount'] as double) >= event.minPrice!).toList();
      }
      if (event.maxPrice != null) {
        filteredExpenses = filteredExpenses.where((e) => (e['amount'] as double) <= event.maxPrice!).toList();
      }
      if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
        final query = event.searchQuery!.toLowerCase();
        filteredExpenses = filteredExpenses.where((e) => (e['name'] as String).toLowerCase().contains(query)).toList();
      }
      // Filter category spending
      Map<String, double> filteredCategorySpending = Map.from(_originalCategorySpending);
      if (event.category != null && event.category!.isNotEmpty) {
        filteredCategorySpending.removeWhere((key, value) => key != event.category);
      }
      // Filter monthly trend
      List<double> filteredMonthlyTrend = List.from(_originalMonthlyTrend);
      if (event.monthIndex != null) {
        filteredMonthlyTrend = [filteredMonthlyTrend[event.monthIndex!]];
      }
      // Calculate filtered totals
      double filteredSpent = filteredExpenses.fold(0.0, (sum, e) => sum + (e['amount'] as double));
      double filteredBudget = 2000.0; // Keep static for now
      emit(AnalyticsLoaded(
        totalBudget: filteredBudget,
        totalSpent: filteredSpent,
        weeklySpending: [200, 150, 300, 100, 250, 150, 100],
        categorySpending: filteredCategorySpending,
        monthlyTrend: filteredMonthlyTrend,
        topExpenses: filteredExpenses,
        categoryBudgets: Map.from(_originalCategoryBudgets),
      ));
    });
  }
}
