import 'dart:convert';

import 'package:my_profile_task/utils/common_method.dart';
import 'package:my_profile_task/utils/preference_constant.dart';
import 'package:my_profile_task/utils/preference_utils.dart';
import 'package:my_profile_task/values/app_strings.dart';

import '../../../utils/response.dart';
import '../model/model.dart';

class AuthenticationRepository {
  var profile = CommonMethod.getProfile ??
      ProfileModel(
          name: "Nehang Patel",
          email: "nehang.patel@tatvasoft.com",
          skill:
              "Flutter (for iOS, Android, Web), BLoC, Dart, Android, Core Java, swift",
          workExperience:
              'I have total 3.5 years of experience in flutter development.'
              'In this span of time developed 11 Projects in which 2 projects support web as well.',
          avatar: null);
  ProfileModel emptyUser = ProfileModel.empty();

  Future<Response<ProfileModel>> loginWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (profile.email?.toLowerCase() != email.toLowerCase()) {
      return Response.error("${AppStrings.errorUserNotFound}${profile.email}");
    } else if (password == "Nehang") {
      if (CommonMethod.getProfile == null) {
        setString(PreferenceConstant.profile, jsonEncode(profile.toJson()));
      }
      return Response.succeed(profile);
    } else {
      return Response.error(AppStrings.errorIncorrectPassword);
    }
  }
}
