import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;

  AppError(this.message);

  @override
  List<Object> get props => [message];
}
