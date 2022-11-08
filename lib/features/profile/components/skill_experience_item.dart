import 'package:flutter/material.dart';

class SkillExperienceItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isEditable;
  final Function()? onEdit;
  const SkillExperienceItem(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.isEditable = false,
      this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              isEditable
                  ? GestureDetector(
                      onTap: onEdit, child: const Icon(Icons.edit))
                  : Container()
            ],
          ),
          const SizedBox(height: 5),
          Text(
            subTitle,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }
}
