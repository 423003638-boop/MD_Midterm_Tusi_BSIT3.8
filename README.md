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

## 🏗️ Object-Oriented Architecture Diagram
