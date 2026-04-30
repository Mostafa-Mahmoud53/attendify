class StudentReport {
  const StudentReport({
    required this.studentId,
    required this.attendanceCount,
    required this.absenceCount,
  });

  final String studentId;
  final int attendanceCount;
  final int absenceCount;
}
