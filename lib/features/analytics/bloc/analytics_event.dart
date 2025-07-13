part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsEvent {}

class LoadAnalyticsEvent extends AnalyticsEvent {}

class FilterAnalyticsEvent extends AnalyticsEvent {
  final int? monthIndex;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? searchQuery;

  FilterAnalyticsEvent({this.monthIndex, this.category, this.minPrice, this.maxPrice, this.searchQuery});
}
