import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_task/core/app_network/constants.dart';
import 'package:qr_code_task/core/app_network/dio_helper.dart';
import 'package:qr_code_task/core/app_services/dependency_injector.dart';
import 'package:qr_code_task/domain/entities/user.dart';
import 'package:qr_code_task/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final loginUseCase = DependencyInjector.dihInstance<LoginUseCase>();
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  login({String? email, String? password}) async {
    debugPrint('email=$email - password=$password');
    emit(UserLoginingState());
    final result = await loginUseCase(email: email, password: password);
    result
        .fold((failure) => emit(UserFailedLoginState(message: failure.message)),
            (userData) {
      NetworkConstants.userToken = userData.token;
      DioHelper.reInit();

      ///update token in dio
      emit(UserSuccessLoginState(user: userData));
    });
  }
}
