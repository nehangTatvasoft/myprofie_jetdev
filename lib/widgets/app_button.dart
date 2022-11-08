import 'package:flutter/material.dart';
import 'package:my_profile_task/values/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const AppButton({Key? key, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.colorBlack,
      child: InkWell(
        splashColor: Colors.black,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: AppColors.colorWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
