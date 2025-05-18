part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final RequestStatus<Map<String, dynamic>> amountCardData;

  const HomeState({this.amountCardData = const RequestStatus.idle()});

  HomeState copyWith({
    RequestStatus<Map<String, dynamic>>? amountCardData,
  }) {
    return HomeState(
      amountCardData: amountCardData ?? this.amountCardData,
    );
  }

  @override
  List<Object?> get props => [amountCardData];
}
