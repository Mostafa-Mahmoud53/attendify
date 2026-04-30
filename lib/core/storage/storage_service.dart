import 'package:hive_flutter/hive_flutter.dart';

import 'storage_keys.dart';

class StorageService {
  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<String>> _openStringBox(String name) async {
    return Hive.openBox<String>(name);
  }

  Future<Box<List>> _openListBox(String name) async {
    return Hive.openBox<List>(name);
  }

  Future<void> saveUserRole(String role) async {
    final box = await _openStringBox(StorageKeys.userRole);
    await box.put(StorageKeys.userRole, role);
  }

  Future<String?> readUserRole() async {
    final box = await _openStringBox(StorageKeys.userRole);
    return box.get(StorageKeys.userRole);
  }

  Future<void> saveStudentProfileLink(String link) async {
    final box = await _openStringBox(StorageKeys.studentProfileBox);
    await box.put(StorageKeys.studentProfileLink, link);
  }

  Future<String?> readStudentProfileLink() async {
    final box = await _openStringBox(StorageKeys.studentProfileBox);
    return box.get(StorageKeys.studentProfileLink);
  }

  Future<void> addSessionAttendee({
    required String sessionId,
    required String studentId,
  }) async {
    final box = await _openListBox(StorageKeys.sessionsBox);
    final attendees = (box.get(sessionId) ?? <String>[]).cast<String>();
    if (attendees.contains(studentId)) {
      return;
    }
    attendees.add(studentId);
    await box.put(sessionId, attendees);
  }

  Future<List<String>> readSessionAttendees(String sessionId) async {
    final box = await _openListBox(StorageKeys.sessionsBox);
    return (box.get(sessionId) ?? <String>[]).cast<String>();
  }

  Future<void> saveStudentLink(String link) async {
    final box = await _openListBox(StorageKeys.studentLinksBox);
    final links = (box.get(StorageKeys.studentLinksBox) ?? <String>[]).cast<String>();
    if (links.contains(link)) {
      return;
    }
    links.add(link);
    await box.put(StorageKeys.studentLinksBox, links);
  }

  Future<List<String>> readStudentLinks() async {
    final box = await _openListBox(StorageKeys.studentLinksBox);
    return (box.get(StorageKeys.studentLinksBox) ?? <String>[]).cast<String>();
  }
}
