import 'package:flutter/material.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';

class NewsDivider extends StatelessWidget {
  const NewsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.padding20,
        vertical: AppSize.padding28,
      ),
      child: const Divider(
        height: 1,
        thickness: 1,
        color: AppColors.divider
      ),
    );
  }
}