import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/base_screen.dart';
import '../application/lecture_report_service.dart';

class LectureReportScreen extends StatelessWidget {
  const LectureReportScreen({super.key});

  static final LectureReportService _service = LectureReportService();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Lecture Report',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _exportToExcel(context),
        label: const Text('Export to Excel'),
        icon: const Icon(Icons.file_download),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Students',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _handleSync(context),
              icon: const Icon(Icons.sync),
              label: const Text('Sync Data'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                return Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Student ${index + 1}'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('Attendance: 8'),
                          Text('Absence: 2'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportToExcel(BuildContext context) async {
    final excel = Excel.createExcel();
    final sheet = excel['Attendance'];

    sheet.appendRow(const ['Student ID', 'Total Attendance', 'Grades']);
    for (var i = 0; i < 10; i += 1) {
      sheet.appendRow(['Student ${i + 1}', 8, 'A']);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/lecture_report.xlsx');
    final bytes = excel.encode();
    if (bytes == null) {
      return;
    }
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles([XFile(file.path)], text: 'Lecture report');

    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report exported successfully.')),
    );
  }

  Future<void> _handleSync(BuildContext context) async {
    await _service.syncStudentData();
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student data synced.')),
    );
  }
}
