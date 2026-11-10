# Community Learning Center Management System

---

## 📖 Project Overview
The **Community Learning Center Management System** is a consolidated Dart console application designed to manage educational resources (physical books and digital online courses) and participant registrations, execute borrowing and course enrollment transactions, track accounts, and generate summary analytics.

The program highlights core Object-Oriented Programming (OOP) concepts, rigorous input validation, error handling, clean architecture, and standard Dart data structures (`List` and `Map`).

---

## ✨ Implemented Features & Rubric Compliance

### 1. Program Setup, Variables, Operators & I/O (Section A)
- Interactive CLI main menu loop providing access to registration, transaction processing, data visualization, and analytical reporting.
- Type-safe usage of Dart data types (`String`, `int`, `double`, `bool`).
- Numerical calculations utilizing mathematical operators (`+`, `/`, `>`, `<=`) for total unpaid balance calculations, course duration averages, and transaction metrics.

### 2. Conditionals, Loops, Functions & Error Handling (Section B)
- Menu navigation controlled via dynamic `switch` statements and `while` execution loops.
- Reusable helper functions (`readNonEmptyString`, `readPositiveDouble`, `findRecordById`) for safe input handling.
- Input validation using `double.tryParse` and `try-catch` blocks to prevent system crashes on invalid user input.

### 3. Encapsulation, Classes & Collections (Section C)
- Private class properties (prefixed with `_`) accessible strictly via public getters, setters, and dedicated methods.
- Structural storage using `List<CenterRecord>` for polymorphic object management.
- Dynamic key-value tracking via `Map<String, List<String>>` (linking participant IDs to active borrowed book IDs) and `Map<String, int>` (tracking system transaction counters).

### 4. OOP Hierarchy: Inheritance, Polymorphism & Mixins (Section D)
- **Abstract Class:** `CenterRecord` serves as the base class defining common properties (`id`, `name`) and abstract methods (`displayDetails()`, `getRecordType()`).
- **Inheritance:** `BookResource`, `DigitalCourseResource`, and `Participant` inherit from `CenterRecord`.
- **Polymorphism:** The system iterates over heterogeneous lists of type `List<CenterRecord>` and invokes overridden methods dynamically at runtime.
- **Mixin:** `Timestampable` provides automatic creation timestamp generation (`formattedTimestamp`) across subclasses.

---


## 🧪 Sample Test Scenarios

### Scenario 1: Pre-loading & Polymorphic Record Display (Valid Input)
1. Launch application and select **Option 8** to pre-load sample test dataset.
2. Select **Option 5** -> **Option 1** to display all records.
3. **Expected Output:** The console displays pre-formatted cards for participants (`P01`, `P02`), book resources (`B01`, `B02`), and digital courses (`C01`, `C02`) with accurate timestamp formatting.

### Scenario 2: Processing Transactions & Analytics (Valid Input)
1. Select **Option 3** -> **Option 1** (Issue Book).
2. Enter Participant ID `P01` and Book ID `B01`.
3. Select **Option 4** (Enroll in Course).
4. Enter Participant ID `P01` and Course ID `C01`.
5. Select **Option 7** (View Analytics).
6. **Expected Output:** System displays confirmation messages, updates `P01`'s balance by `$49.99`, marks `B01` as checked out, and reflects updated statistics in the analytics summary.

### Scenario 3: Error Handling & Invalid Input Validation (Error Handling)
1. Select **Option 2** -> **Option 2** (Add Digital Course).
2. Enter Course ID `C03`, Title `Advanced Dart`, Instructor `Dr. Alex`.
3. Enter invalid text for Duration: `fifteen`.
4. **Expected Output:** System catches format exception, displays `❌ Invalid number format. Please enter a valid positive double`, and prompts user again without terminating the program.
5. Select **Option 3** -> **Option 1** (Issue Book).
6. Enter non-existent Participant ID `P99`.
7. **Expected Output:** System catches missing entity error and displays `❌ [ERROR] Participant with ID "P99" was not found.`

---

## 🚀 How to Run the Application

### Option A: Running locally via Dart SDK
1. Ensure the [Dart SDK](https://dart.dev/get-dart) is installed on your environment.
2. Clone this repository:
   ```bash
   git clone [https://github.com/](https://github.com/)[YOUR_USERNAME]/MD_Midterm_[Surname]_[Section].git
