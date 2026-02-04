# Finance Operations App

A production-grade Flutter mobile app for multi-tenant Agency Finance Operations.

## Features

- **Clean Architecture**: Strictly separated Presentation, Domain, and Data layers.
- **State Management**: Riverpod (hooks_riverpod) + Flutter Hooks.
- **Navigation**: GoRouter with ShellRoute for persistent bottom navigation.
- **Design System**: Custom ThemeExtensions for strict token usage (Colors, Typography).
- **Core Modules**:
  - **Auth**: Login flow with mocked authentication.
  - **Dashboard**: KPI Cards, Cashflow Chart (fl_chart), Recent Activity.
  - **Transactions**: List with Search/Filter, Detail View, Add Transaction Wizard.
  - **Approvals**: Inbox for pending transactions.
  - **Reports**: Reports Hub UI.
  - **Settings/More**: Secondary resource management (Vendors, Bank Accounts).
- **Core Features**:
  - **Persistence**: Auth state saved via `shared_preferences`.
  - **Onboarding**: Company setup wizard for new users.
  - **Validation**: Robust form handling.

## Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Dart SDK

### Installation

1. Clone the repository.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the code generator (for JsonSerializable):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Running the App

```bash
flutter run
```

## Architecture Overview

The project follows a Feature-First Clean Architecture:

```
lib/
├── core/               # Shared kernel (Theme, Routing, Widgets, Utils)
├── data/               # Data layer (Repositories, Mocks)
├── domain/             # Business Logic (Models, Enums, Interfaces)
├── features/           # Feature modules
│   ├── auth/
│   ├── home/
│   ├── transactions/
│   ├── approvals/
│   ├── reports/
│   └── more/
└── app.dart            # Root Widget
```

### Key Decisions

- **Mock Data**: Uses in-memory mock repositories (`lib/data/mocks/`) to simulate a backend.
- **Strict Typing**: All models use `json_serializable` and `equatable`. Enums are used exhaustive switches.
- **UI Components**: Reusable widgets in `lib/core/widgets/`.

## Testing

Run static analysis:

```bash
flutter analyze
```
