import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import 'app_button.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.scrollable = false,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool safeArea;
  final bool resizeToAvoidBottomInset;
  final bool scrollable;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = _buildContent(context, scheme);

    return Scaffold(
      appBar: appBar ?? _buildAppBar(context, scheme),
      body: safeArea ? SafeArea(child: content) : content,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: scheme.background,
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme scheme) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return _buildError(context, scheme, errorMessage!);
    }

    if (scrollable) {
      return SingleChildScrollView(
        padding: padding ?? AppSpacing.screenPadding,
        child: body,
      );
    }

    return Padding(
      padding: padding ?? AppSpacing.screenPadding,
      child: body,
    );
  }

  Widget _buildError(BuildContext context, ColorScheme scheme, String message) {
    return Center(
      child: Padding(
        padding: padding ?? AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: scheme.onBackground),
            ),
            const SizedBox(height: AppSpacing.md),
            if (onRetry != null)
              AppButton(
                label: 'Retry',
                onPressed: onRetry,
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context, ColorScheme scheme) {
    if (title == null && actions == null) {
      return null;
    }

    return AppBar(
      title: title == null ? null : Text(title!),
      actions: actions,
      elevation: 0,
      backgroundColor: scheme.background,
      foregroundColor: scheme.onBackground,
      surfaceTintColor: scheme.background,
    );
  }
}
