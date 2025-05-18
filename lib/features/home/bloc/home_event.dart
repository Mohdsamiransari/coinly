part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class GetTotalBalanceEvent extends HomeEvent{}

final class AddNewTotalBalanceEvent extends HomeEvent{}

final class GetAllRecentTransactionsEvent extends HomeEvent{}
