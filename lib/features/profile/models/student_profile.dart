// File: lib/features/profile/models/student_profile.dart
// Purpose: Profile domain models for student, academic, attendance, research, and financial data.

enum ProgramType { undergraduate, postgraduate, doctorate }

enum EnrollmentStatus { active, onLeave, graduated, suspended }

enum AcademicStanding { deanslist, goodStanding, probation, warning }

enum FeeStatus { paid, pending, partial }

class CourseAttendance {
  final String courseCode;
  final String courseName;
  final int attended;
  final int total;

  const CourseAttendance({
    required this.courseCode,
    required this.courseName,
    required this.attended,
    required this.total,
  });

  double get percentage => total == 0 ? 0 : (attended / total) * 100;
}

class SemesterCourse {
  final String code;
  final String name;
  final int creditHours;
  final String grade;
  final double gradePoints;

  const SemesterCourse({
    required this.code,
    required this.name,
    required this.creditHours,
    required this.grade,
    required this.gradePoints,
  });
}

class ResearchInfo {
  final String title;
  final String supervisorName;
  final String? coSupervisor;
  final String researchArea;
  final int publicationsCount;
  final String? defenseDate;
  final String defenseStatus;
  final int conferencePresentations;

  const ResearchInfo({
    required this.title,
    required this.supervisorName,
    this.coSupervisor,
    required this.researchArea,
    required this.publicationsCount,
    this.defenseDate,
    required this.defenseStatus,
    required this.conferencePresentations,
  });
}

class StudentProfile {
  final String studentId;
  final String fullName;
  final String department;
  final String faculty;
  final String program;
  final ProgramType programType;
  final int currentSemester;
  final int totalSemesters;
  final EnrollmentStatus enrollmentStatus;
  final AcademicStanding academicStanding;
  final double cgpa;
  final double semesterGpa;
  final int creditHoursCompleted;
  final int creditHoursRequired;
  final List<SemesterCourse> currentCourses;
  final List<double> gpaHistory;
  final List<CourseAttendance> attendance;
  final String dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String cnic;
  final String personalEmail;
  final String universityEmail;
  final String phone;
  final String emergencyContact;
  final String address;
  final String? major;
  final String? minor;
  final String? internshipStatus;
  final ResearchInfo? research;
  final FeeStatus feeStatus;
  final double outstandingDues;
  final String? scholarshipName;
  final double? scholarshipDiscount;
  final String? profileImagePath;

  const StudentProfile({
    required this.studentId,
    required this.fullName,
    required this.department,
    required this.faculty,
    required this.program,
    required this.programType,
    required this.currentSemester,
    required this.totalSemesters,
    required this.enrollmentStatus,
    required this.academicStanding,
    required this.cgpa,
    required this.semesterGpa,
    required this.creditHoursCompleted,
    required this.creditHoursRequired,
    required this.currentCourses,
    required this.gpaHistory,
    required this.attendance,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.cnic,
    required this.personalEmail,
    required this.universityEmail,
    required this.phone,
    required this.emergencyContact,
    required this.address,
    this.major,
    this.minor,
    this.internshipStatus,
    this.research,
    required this.feeStatus,
    required this.outstandingDues,
    this.scholarshipName,
    this.scholarshipDiscount,
    this.profileImagePath,
  });
}
