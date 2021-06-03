import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];
}

enum AppErrorType { api, network }
