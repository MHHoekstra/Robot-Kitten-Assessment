import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

class ThisMonthList extends StatelessWidget {
  const ThisMonthList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "This month",
            style: AppFonts.h3,
          ),
        ),
        ...List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200,
              color: AppColors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
