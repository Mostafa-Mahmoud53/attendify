import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/storage/storage_service.dart';
import '../../../shared/widgets/base_screen.dart';
import '../../../core/routing/app_router.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Dashboard',
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Doctor',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          _DashboardGrid(onCreateSession: () => _showCreateSession(context)),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Recent Sessions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          const _RecentSessionsList(),
        ],
      ),
    );
  }

  void _showCreateSession(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: AppSpacing.radiusLg),
      ),
      builder: (_) => const _CreateSessionSheet(),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  const _DashboardGrid({required this.onCreateSession});

  final VoidCallback onCreateSession;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _DashboardCard(
          title: 'Create Session',
          icon: Icons.add_circle_outline,
          onTap: onCreateSession,
        ),
        _DashboardCard(
          title: 'Sync Data',
          icon: Icons.sync,
          onTap: () {},
        ),
        _DashboardCard(
          title: 'Lecture Reports',
          icon: Icons.bar_chart,
          onTap: () => Navigator.of(context).pushNamed(AppRouter.lectureReport),
        ),
        _DashboardCard(
          title: 'Absence Warnings',
          icon: Icons.warning_amber_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusLg,
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppSpacing.borderRadiusLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: scheme.primary),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSessionsList extends StatelessWidget {
  const _RecentSessionsList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: serviceLocator<StorageService>().readSessionAttendees('latest'),
      builder: (context, snapshot) {
        final sessions = snapshot.data ?? [];
        if (sessions.isEmpty) {
          return Text(
            'No sessions yet.',
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
        return Column(
          children: sessions
              .take(3)
              .map(
                (session) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(session),
                      Text('${sessions.length} attendees'),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _CreateSessionSheet extends StatefulWidget {
  const _CreateSessionSheet();

  @override
  State<_CreateSessionSheet> createState() => _CreateSessionSheetState();
}

class _CreateSessionSheetState extends State<_CreateSessionSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Session',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Session Code',
              suffixIcon: IconButton(
                icon: const Icon(Icons.shuffle),
                onPressed: _generateCode,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _startSession,
              child: const Text('Start Session'),
            ),
          ),
        ],
      ),
    );
  }

  void _generateCode() {
    final value = (DateTime.now().millisecondsSinceEpoch % 90) + 10;
    _controller.text = value.toString();
  }

  void _startSession() {
    final code = _controller.text.trim();
    if (code.isEmpty) {
      return;
    }
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
      AppRouter.liveScanner,
      arguments: code,
    );
  }
}
