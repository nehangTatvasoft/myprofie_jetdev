import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/features/authentication/repository/authentication_repository.dart';
import 'package:my_profile_task/utils/Navigations/app_routes.dart';
import 'package:my_profile_task/utils/Navigations/navigation_routes.dart';
import 'package:my_profile_task/utils/extensions.dart';
import 'package:my_profile_task/values/app_colors.dart';
import 'package:my_profile_task/widgets/app_check_box.dart';

import '../../../../utils/progress_dialog.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../bloc/authentication_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(AuthenticationRepository()),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            ProgressDialogUtil.showProgressDialog(context);
          } else if (state is AuthenticationSucceed) {
            ProgressDialogUtil.dismissProgressDialog(context);
            context.showSnackBar("User Logged in successfully");
            NavigationRoutes.pushAndRemoveUntil(context, Screens.profile);
          } else if (state is AuthenticationError) {
            ProgressDialogUtil.dismissProgressDialog(context);
            context.showSnackBar(state.error, isError: true);
          }
        },
        builder: (context, state) {
          AuthenticationCubit cubit = BlocProvider.of(context);
          return Scaffold(
            backgroundColor: AppColors.colorWhite,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please sign in to continue",
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AppTextField(
                          controller: cubit.emailController,
                          inputType: TextInputType.emailAddress,
                          hint: "Email",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: cubit.passwordController,
                          obscureText: true,
                          inputType: TextInputType.visiblePassword,
                          hint: "Password",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppCheckBox(
                            isChecked: cubit.rememberMe,
                            label: "Remember me",
                            onChange: (bool isChecked) {
                              cubit.changeRememberMe(isChecked);
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        AppButton(
                          text: "Login",
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            cubit.login();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
