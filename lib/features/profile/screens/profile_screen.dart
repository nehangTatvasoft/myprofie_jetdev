import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_task/features/profile/bloc/profile_cubit.dart';
import 'package:my_profile_task/features/profile/screens/edit_profile.dart';
import 'package:my_profile_task/features/profile/screens/my_profile.dart';

import '../../../values/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) => current is! ProfileError,
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          return Scaffold(
              backgroundColor: AppColors.colorWhite,
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  cubit.setBottomNavigationBarIndex(value);
                },
                currentIndex: cubit.bottomNavigationBarIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: "Profile"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit), label: "Edit Profile")
                ],
              ),
              body: cubit.bottomNavigationBarIndex == 0
                  ? const MyProfile()
                  : const EditProfile());
        },
      ),
    );
  }
}
