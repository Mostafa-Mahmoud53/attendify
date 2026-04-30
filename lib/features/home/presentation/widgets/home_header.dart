import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.appName,
          style: AppTypography.title(Theme.of(context).colorScheme),
        ),
        const SizedBox(height: AppSpacing.sm),
        const Text('Feature-first clean architecture'),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
