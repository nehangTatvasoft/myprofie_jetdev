import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/utils/preference_constant.dart';
import 'package:my_profile_task/utils/preference_utils.dart';

import '../../../utils/response.dart';
import '../../../utils/validations.dart';
import '../repository/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  AuthenticationRepository authenticationRepository;

  AuthenticationCubit(this.authenticationRepository)
      : super(AuthenticationInitial()) {
    rememberMe = getString(PreferenceConstant.rememberedMail).isNotEmpty;
    getSavedEmail();
  }

  getSavedEmail() async {
    emailController.text = getString(PreferenceConstant.rememberedMail, null);
  }

  login() async {
    if (loginFormValid()) {
      emit(AuthenticationLoading());
      var result = await authenticationRepository.loginWithEmailAndPassword(
          emailController.text, passwordController.text);
      if (result.status == Status.SUCCEED) {
        setString(PreferenceConstant.rememberedMail,
            rememberMe ? emailController.text : "");
        setString(
            PreferenceConstant.profile, jsonEncode(result.data?.toJson()));
        setBool(PreferenceConstant.isLoggedIn, true);
        emit(AuthenticationSucceed());
      } else {
        emit(AuthenticationError(result.message ?? ""));
      }
    }
  }

  bool loginFormValid() {
    String emailError = Validations.validateEmail(emailController.text);
    String passwordError =
        Validations.validatePassword(passwordController.text);
    if (emailError.isNotEmpty) {
      emit(AuthenticationError(emailError));
      return false;
    } else if (passwordError.isNotEmpty) {
      emit(AuthenticationError(passwordError));
      return false;
    } else {
      return true;
    }
  }

  changeRememberMe(bool isChecked) {
    rememberMe = isChecked;
    emit(RememberMeChanged());
  }
}
