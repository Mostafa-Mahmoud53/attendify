# 📱 Flutter Bluetooth Attendance App — Feature Prompts

This document contains structured prompts for generating the core features of the app.
Each prompt is designed to be used independently with AI coding tools.

---

## 🔹 Task 1 — Role Selection

Create a Role Selection screen in Flutter.

### UI:
- Two large selectable cards:
  - "I am a Doctor"
  - "I am a Student"
- Each card:
  - Centered icon and text
  - Uses primary color for icon
  - Rounded corners
  - Smooth scale animation on tap

- Layout:
  - Simple top header text
  - Centered content with proper spacing

### Logic:
- On tap:
  - Save selected role locally using Hive (key: user_role)

### Navigation:
- Doctor → DoctorDashboardScreen
- Student → StudentSetupScreen
- Clear navigation stack after selection

### Rules:
- Keep UI minimal
- Avoid direct Hive calls inside UI

### Deliver:
- role_selection_screen.dart

---

## 🔹 Task 2 — Student Setup (QR Scanner)

Create a Student Setup screen using mobile_scanner.

### UI:
- AppBar title: "Scan College ID"
- Centered square scanner
- Rounded overlay for scan area
- Helper text below scanner:
  "Position your ID QR code inside the frame to register your profile"

### Logic:
- On QR scan:
  - Extract scanned value (URL/link)
  - Stop scanner immediately
  - Save using Hive:
    - box: student_profile
    - key: profile_link

### Navigation:
- Navigate to StudentBroadcasterScreen
- Show success SnackBar

### Rules:
- Prevent duplicate scans
- Stop camera after success

### Deliver:
- student_setup_screen.dart

---

## 🔹 Task 3 — Student Broadcaster

Create Student Broadcaster screen.

### UI:
- Header:
  - "Student Profile"
  - Avatar placeholder

- Card:
  - "Attendance Submission"
  - Input field for numeric session code
  - Large submit button

### Behavior:
- On button press:
  - Show loading state
  - Display broadcasting animation (pulse/ripple)

### Logic:
- Start BLE broadcast using flutter_ble_peripheral
- On stop signal:
  - Trigger haptic feedback
  - Stop broadcast
  - Show success state:
    - Large checkmark
    - "Attendance Recorded Successfully"

### States:
- idle
- broadcasting
- success

### Deliver:
- student_broadcaster_screen.dart

---

## 🔹 Task 4 — Doctor Dashboard

Create Doctor Dashboard screen.

### UI:
- Header with welcome message

- Grid (2 columns):
  - Create Session
  - Sync Data
  - Lecture Reports
  - Absence Warnings

- Cards:
  - White background
  - Rounded corners
  - Icon (top-left)
  - Title (bottom-left)

- Section:
  - "Recent Sessions"
  - List showing:
    - Date
    - Number of attendees

### Logic:
- Load sessions from Hive

### Interaction:
- "Create Session":
  - Open modal bottom sheet
  - Input or generate 2-digit session code
  - Navigate to LiveScannerScreen

### Deliver:
- doctor_dashboard_screen.dart

---

## 🔹 Task 5 — Live Scanner (Doctor BLE)

Create Live Scanner screen using flutter_blue_plus.

### UI:
- AppBar:
  - "Live Session Active"
  - Red pulsing indicator

- Top:
  - Large session code

- Middle:
  - Counter:
    "X Students Recorded"

- Bottom:
  - Animated list of students
  - Each item:
    - White card
    - Green check icon

### Logic:
- Start BLE scan
- For each device:
  - Validate packet (placeholder)
  - If valid:
    - Save student ID to Hive
    - Send stop signal via GATT write
    - Add to list

### Behavior:
- Real-time updates
- Prevent duplicates

### Deliver:
- live_scanner_screen.dart

---

## 🔹 Task 6 — Lecture Report + Export

Create Lecture Report screen.

### UI:
- List of students
- Each item:
  - Student ID or name
  - Attendance count
  - Absence count

- Floating Action Button:
  - "Export to Excel"

### Logic:
- exportToExcel():
  - Use excel package
  - Columns:
    - A: Student ID
    - B: Total Attendance
    - C: Grades

- Save file using path_provider
- Share using share_plus

### Additional:
- Sync Data:
  - Loop through stored student links
  - Perform HTTP GET
  - Extract name if available
  - Update local storage

### Deliver:
- lecture_report_screen.dart
- export function

---

## ✅ Usage Notes

- Run prompts one by one
- Do not merge multiple tasks into a single generation
- Verify output after each step before continuing
- Keep UI and logic separated

---