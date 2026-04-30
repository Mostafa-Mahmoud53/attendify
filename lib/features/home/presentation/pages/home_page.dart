import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeHeader(),
          SizedBox(height: AppSpacing.lg),
          Text('Clean architecture scaffold ready.'),
        ],
      ),
    );
  }
}
