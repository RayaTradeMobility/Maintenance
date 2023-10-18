// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:maintenance/Models/loginModel.dart';
import 'package:meta/meta.dart';

import '../API/API.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginModel? user;
  API api = API();

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());

    // try {
    //   user = await api.login(email, password);
    //   emit(LoginSuccess());
    // } on Exception catch (e) {
    //   emit(LoginFailure());
    // }
  }
}
