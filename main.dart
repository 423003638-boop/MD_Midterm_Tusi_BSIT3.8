mixin Timestampable {
  final DateTime _createdAt = DateTime.now();

  DateTime get createdAt => _createdAt;

  String get formattedTimestamp {
    final year = _createdAt.year;
    final month = _createdAt.month.toString().padLeft(2, '0');
    final day = _createdAt.day.toString().padLeft(2, '0');
    final hour = _createdAt.hour.toString().padLeft(2, '0');
    final minute = _createdAt.minute.toString().padLeft(2, '0');
    final second = _createdAt.second.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute:$second';
  }
}

abstract class CenterRecord with Timestampable {
  final String _id;
  String _name;

  CenterRecord(this._id, this._name);

  String get id => _id;
  String get name => _name;

  set name(String newName) {
    if (newName.trim().isNotEmpty) {
      _name = newName.trim();
    }
  }

  void displayDetails();
  String getRecordType();
}

class BookResource extends CenterRecord {
  final String _author;
  final String _isbn;
  bool _isAvailable;
  int _borrowCount;

  BookResource({
    required String id,
    required String title,
    required String author,
    required String isbn,
    bool isAvailable = true,
    int borrowCount = 0,
  })  : _author = author,
        _isbn = isbn,
        _isAvailable = isAvailable,
        _borrowCount = borrowCount,
        super(id, title);

  String get author => _author;
  String get isbn => _isbn;
  bool get isAvailable => _isAvailable;
  int get borrowCount => _borrowCount;

  void markAsBorrowed() {
    _isAvailable = false;
    _borrowCount++;
  }

  void markAsReturned() {
    _isAvailable = true;
  }

  @override
  String getRecordType() => 'Book Resource';

  @override
  void displayDetails() {
    print('┌─────────────────────────────────────────────────────────────┐');
    print('│ [ID: $_id] TYPE: Book Resource');
    print('├─────────────────────────────────────────────────────────────┤');
    print('│ Title:          $_name');
    print('│ Author:         $_author');
    print('│ ISBN:           $_isbn');
    print('│ Availability:   ${_isAvailable ? "AVAILABLE" : "CHECKED OUT"}');
    print('│ Times Borrowed: $_borrowCount');
    print('│ Registered On:  $formattedTimestamp');
    print('└─────────────────────────────────────────────────────────────┘');
  }
}

class DigitalCourseResource extends CenterRecord {
  final String _instructor;
  final double _durationHours;
  final double _courseFee;
  int _enrolledCount;

  DigitalCourseResource({
    required String id,
    required String title,
    required String instructor,
    required double durationHours,
    required double courseFee,
    int enrolledCount = 0,
  })  : _instructor = instructor,
        _durationHours = durationHours,
        _courseFee = courseFee,
        _enrolledCount = enrolledCount,
        super(id, title);

  String get instructor => _instructor;
  double get durationHours => _durationHours;
  double get courseFee => _courseFee;
  int get enrolledCount => _enrolledCount;

  void enrollStudent() {
    _enrolledCount++;
  }

  @override
  String getRecordType() => 'Digital Course';

  @override
  void displayDetails() {
    print('┌─────────────────────────────────────────────────────────────┐');
    print('│ [ID: $_id] TYPE: Digital Course');
    print('├─────────────────────────────────────────────────────────────┤');
    print('│ Title:          $_name');
    print('│ Instructor:     $_instructor');
    print('│ Duration:       ${_durationHours.toStringAsFixed(1)} Hours');
    print('│ Course Fee:     \$${_courseFee.toStringAsFixed(2)}');
    print('│ Enrollees:      $_enrolledCount');
    print('│ Registered On:  $formattedTimestamp');
    print('└─────────────────────────────────────────────────────────────┘');
  }
}

class Participant extends CenterRecord {
  final String _email;
  final String _role;
  double _accountBalance;

  Participant({
    required String id,
    required String name,
    required String email,
    required String role,
    double accountBalance = 0.0,
  })  : _email = email,
        _role = role,
        _accountBalance = accountBalance,
        super(id, name);

  String get email => _email;
  String get role => _role;
  double get accountBalance => _accountBalance;

  void addCharge(double amount) {
    if (amount > 0) {
      _accountBalance += amount;
    }
  }

  @override
  String getRecordType() => 'Participant';

  @override
  void displayDetails() {
    print('┌─────────────────────────────────────────────────────────────┐');
    print('│ [ID: $_id] TYPE: Participant Record');
    print('├─────────────────────────────────────────────────────────────┤');
    print('│ Name:           $_name');
    print('│ Email:          $_email');
    print('│ Role:           $_role');
    print('│ Balance Due:    \$${_accountBalance.toStringAsFixed(2)}');
    print('│ Registered On:  $formattedTimestamp');
    print('└─────────────────────────────────────────────────────────────┘');
  }
}

class LearningCenterManager {
  final List<CenterRecord> _records = [];
  final Map<String, List<String>> _activeBorrows = {};
  final Map<String, int> _transactionCounts = {
    'books_borrowed': 0,
    'books_returned': 0,
    'course_enrollments': 0,
  };

  List<CenterRecord> get records => List.unmodifiable(_records);
  Map<String, List<String>> get activeBorrows => Map.unmodifiable(_activeBorrows);

  bool addRecord(CenterRecord record) {
    if (_records.any((r) => r.id.toLowerCase() == record.id.toLowerCase())) {
      print('❌ [ERROR] Record with ID "${record.id}" already exists.');
      return false;
    }
    _records.add(record);
    print('✅ [SUCCESS] ${record.getRecordType()} "${record.name}" added successfully.');
    return true;
  }

  CenterRecord? findRecordById(String id) {
    try {
      return _records.firstWhere((r) => r.id.toLowerCase() == id.trim().toLowerCase());
    } catch (_) {
      return null;
    }
  }

  bool borrowBook(String participantId, String bookId) {
    final pRecord = findRecordById(participantId);
    final bRecord = findRecordById(bookId);

    if (pRecord == null || pRecord is! Participant) {
      print('❌ [ERROR] Participant with ID "$participantId" was not found.');
      return false;
    }
    if (bRecord == null || bRecord is! BookResource) {
      print('❌ [ERROR] Book resource with ID "$bookId" was not found.');
      return false;
    }
    if (!bRecord.isAvailable) {
      print('❌ [ERROR] Book "${bRecord.name}" is currently checked out.');
      return false;
    }

    bRecord.markAsBorrowed();
    _activeBorrows.putIfAbsent(participantId, () => []).add(bookId);
    _transactionCounts['books_borrowed'] = (_transactionCounts['books_borrowed'] ?? 0) + 1;

    print('✅ [SUCCESS] Book "${bRecord.name}" issued to ${pRecord.name}.');
    return true;
  }

  bool enrollInCourse(String participantId, String courseId) {
    final pRecord = findRecordById(participantId);
    final cRecord = findRecordById(courseId);

    if (pRecord == null || pRecord is! Participant) {
      print('❌ [ERROR] Participant with ID "$participantId" was not found.');
      return false;
    }
    if (cRecord == null || cRecord is! DigitalCourseResource) {
      print('❌ [ERROR] Digital course with ID "$courseId" was not found.');
      return false;
    }

    cRecord.enrollStudent();
    pRecord.addCharge(cRecord.courseFee);
    _transactionCounts['course_enrollments'] = (_transactionCounts['course_enrollments'] ?? 0) + 1;

    print('✅ [SUCCESS] ${pRecord.name} enrolled in course "${cRecord.name}". Fee: \$${cRecord.courseFee}');
    return true;
  }

  void displayAnalytics() {
    print('\n=============================================================');
    print('           COMMUNITY LEARNING CENTER ANALYTICS               ');
    print('=============================================================');

    int participantCount = 0;
    int bookCount = 0;
    int courseCount = 0;
    double totalOutstandingFees = 0.0;
    double totalCourseHours = 0.0;

    for (var record in _records) {
      if (record is Participant) {
        participantCount++;
        totalOutstandingFees += record.accountBalance;
      } else if (record is BookResource) {
        bookCount++;
      } else if (record is DigitalCourseResource) {
        courseCount++;
        totalCourseHours += record.durationHours;
      }
    }

    final totalRecords = _records.length;
    final averageCourseHours = courseCount > 0 ? (totalCourseHours / courseCount) : 0.0;

    print(' Total Registered Records:      $totalRecords');
    print('  ├─ Registered Participants:   $participantCount');
    print('  ├─ Book Resources:            $bookCount');
    print('  └─ Digital Courses:           $courseCount');
    print('-------------------------------------------------------------');
    print(' Average Digital Course Length: ${averageCourseHours.toStringAsFixed(1)} hours');
    print(' Total Outstanding Fees Due:    \$${totalOutstandingFees.toStringAsFixed(2)}');
    print(' Total Books Borrowed Count:    ${_transactionCounts['books_borrowed']}');
    print(' Total Course Enrollments:      ${_transactionCounts['course_enrollments']}');
    print('=============================================================\n');
  }

  void displayAllRecords() {
    print('\n=============================================================');
    print('               COMMUNITY CENTER RECORDS DATABASE             ');
    print('=============================================================');
    for (var record in _records) {
      record.displayDetails();
      print('');
    }
  }
}

void main() {
  final manager = LearningCenterManager();

  print('''
=============================================================
    COMMUNITY LEARNING CENTER MANAGEMENT SYSTEM
    Mobile Development • Midterm Laboratory Project
=============================================================
''');

  print('--- SCENARIO 1: Registering Participants & Resources ---');
  manager.addRecord(Participant(id: 'P01', name: 'Maria Santos', email: 'maria@example.com', role: 'Student'));
  manager.addRecord(Participant(id: 'P02', name: 'Juan Dela Cruz', email: 'juan@example.com', role: 'Resident'));
  manager.addRecord(BookResource(id: 'B01', title: 'Dart & Flutter Guide', author: 'Jane Doe', isbn: '978-1111111111'));
  manager.addRecord(DigitalCourseResource(id: 'C01', title: 'Web Basics', instructor: 'Prof. Smith', durationHours: 15.0, courseFee: 49.99));

  print('\n--- SCENARIO 2: Valid Transactions & Enrollments ---');
  manager.borrowBook('P01', 'B01');
  manager.enrollInCourse('P01', 'C01');

  print('\n--- SCENARIO 3: Error Handling & Invalid Inputs ---');
  print('Test 3a: Duplicate ID Registration');
  manager.addRecord(Participant(id: 'P01', name: 'Duplicate User', email: 'dup@example.com', role: 'Student'));

  print('\nTest 3b: Borrowing Already Borrowed Book');
  manager.borrowBook('P02', 'B01');

  print('\nTest 3c: Searching Non-existent Record');
  manager.borrowBook('P99', 'B01');

  print('\n--- SCENARIO 4: View Polymorphic Records ---');
  manager.displayAllRecords();

  print('\n--- SCENARIO 5: Display Mathematical Analytics ---');
  manager.displayAnalytics();
}
