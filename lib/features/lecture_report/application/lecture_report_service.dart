import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/di/service_locator.dart';
import '../../../core/storage/storage_service.dart';

class LectureReportService {
  Future<void> syncStudentData() async {
    final storage = serviceLocator<StorageService>();
    final links = await storage.readStudentLinks();
    for (final link in links) {
      try {
        final response = await http.get(Uri.parse(link));
        if (response.statusCode != 200) {
          continue;
        }
        final json = jsonDecode(response.body);
        final name = json is Map<String, dynamic> ? json['name']?.toString() : null;
        if (name != null && name.isNotEmpty) {
          // Placeholder: store names later.
        }
      } catch (_) {
        // Ignore errors for now.
      }
    }
  }
}
