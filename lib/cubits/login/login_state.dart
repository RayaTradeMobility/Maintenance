part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginsInitial extends LoginState {}
class LoginsSuccess extends LoginState {}
class LoginsWaiting extends LoginState {}
class LoginsFailure extends LoginState {}