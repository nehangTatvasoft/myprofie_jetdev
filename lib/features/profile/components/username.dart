import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/features/profile/bloc/profile_cubit.dart';
import 'package:my_profile_task/utils/common_method.dart';
import 'package:my_profile_task/values/app_strings.dart';

import '../../../values/app_colors.dart';

class Username extends StatefulWidget {
  final bool isEditable;

  const Username({Key? key, this.isEditable = false}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      buildWhen: (previous, current) => current is! ProfileError,
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cubit.profile?.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: widget.isEditable,
                    child: GestureDetector(
                        onTap: () {
                          CommonMethod().openEditBottomSheet(
                              AppStrings.userName,
                              1,
                              (value) => cubit.changeProfileData("name", value),
                              cubit.profile?.name);
                        },
                        child: Icon(
                          size: 20,
                          Icons.edit,
                          color: AppColors.colorBlack,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cubit.profile?.email ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: widget.isEditable,
                    child: GestureDetector(
                        onTap: () {
                          CommonMethod().openEditBottomSheet(
                              AppStrings.email,
                              1,
                              (value) =>
                                  cubit.changeProfileData("email", value),
                              cubit.profile?.email);
                        },
                        child: Icon(
                          size: 20,
                          Icons.edit,
                          color: AppColors.colorBlack,
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
