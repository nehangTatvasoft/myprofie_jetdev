import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/features/profile/components/profile_picture.dart';
import 'package:my_profile_task/features/profile/components/skill_experience_item.dart';
import 'package:my_profile_task/features/profile/components/username.dart';
import 'package:my_profile_task/utils/Navigations/app_routes.dart';
import 'package:my_profile_task/utils/common_method.dart';
import 'package:my_profile_task/utils/preference_constant.dart';
import 'package:my_profile_task/utils/preference_utils.dart';

import '../../../utils/Navigations/navigation_routes.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_strings.dart';
import '../bloc/profile_cubit.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is! ProfileError,
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: [
              TextButton.icon(
                  onPressed: () => CommonMethod.openAlertDialog(
                      AppStrings.logoutConfirmationText,
                      () => doLogout(context)),
                  icon: Icon(Icons.logout, color: AppColors.colorBlack),
                  label: Text(
                    AppStrings.logout,
                    style: TextStyle(color: AppColors.colorBlack),
                  ))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfilePicture(),
                  const Username(),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SkillExperienceItem(
                      title: 'Skill', subTitle: cubit.profile?.skill ?? ""),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SkillExperienceItem(
                      title: 'Work Experience',
                      subTitle: cubit.profile?.workExperience ?? ""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  doLogout(BuildContext context) {
    String rememberedEmail = getString(PreferenceConstant.rememberedMail);
    clear();
    setString(PreferenceConstant.rememberedMail, rememberedEmail);
    NavigationRoutes.pop(context);
    NavigationRoutes.pushAndRemoveUntil(context, Screens.login);
  }
}
