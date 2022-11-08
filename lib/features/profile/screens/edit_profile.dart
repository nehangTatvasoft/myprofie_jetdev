import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/values/app_colors.dart';
import 'package:my_profile_task/values/app_strings.dart';

import '../../../utils/Navigations/app_routes.dart';
import '../../../utils/common_method.dart';
import '../bloc/profile_cubit.dart';
import '../components/profile_picture.dart';
import '../components/skill_experience_item.dart';
import '../components/username.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  state.message,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          );
        } else if (state is ProfileSuccess) {
          NavigationRoutes.pop(context);
        }
      },
      buildWhen: (previous, current) {
        return current is! ProfileError;
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            elevation: 0.0,
          ),
          backgroundColor: AppColors.colorWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfilePicture(isEditable: true),
                  const SizedBox(
                    height: 10,
                  ),
                  const Username(isEditable: true),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SkillExperienceItem(
                    title: AppStrings.skill,
                    subTitle: cubit.profile?.skill ?? "",
                    isEditable: true,
                    onEdit: () {
                      CommonMethod().openEditBottomSheet(
                          AppStrings.skill,
                          4,
                          (value) => cubit.changeProfileData("skill", value),
                          cubit.profile?.skill);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SkillExperienceItem(
                    title: AppStrings.workExperience,
                    subTitle: cubit.profile?.workExperience ?? "",
                    isEditable: true,
                    onEdit: () {
                      CommonMethod().openEditBottomSheet(
                          AppStrings.workExperience,
                          4,
                          (value) =>
                              cubit.changeProfileData("workExperience", value),
                          cubit.profile?.workExperience);
                    },
                  ),
                ],
              ),
            ),
          ), //buildEditProfileWidget(),
        );
      },
    );
  }
}
