import 'package:coinly/features/auth/bloc/auth_bloc.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> blocProviders = [
  BlocProvider(
    create: (context) => AuthBloc(),
  ),
  BlocProvider(
    create: (context) => HomeBloc(),
  ),
  BlocProvider(
    create: (context) => ExpenseBloc(),
  ),
];
