# Commit Dashboard

Commit Dashboard is a cross-platform Flutter application for viewing and discussing electricity-consumption forecasts. It presents a regional overview, neighborhood-level demand, active alerts, decisions, and settings in a single dashboard.

The application is written with Dart and Flutter. It supports Windows and web builds from the same source code.

## What the application does

- Shows yesterday's total electricity consumption.
- Compares consumption with the previous seven-day average.
- Shows forecasted demand and maximum predicted temperature.
- Displays active alert counts and critical-alert counts.
- Filters a consumption chart by neighborhood.
- Compares a neighborhood's six-month consumption history with the regional average.
- Compares each neighborhood's forecasted peak with its available capacity.
- Separates the dashboard into Panel, Alertas, Decisoes, and Ajustes navigation tabs.
- Opens an alert-detail view when a neighborhood ranking is selected.
- Allows the data view to be refreshed through a pull-to-refresh interaction.

The current dashboard uses clearly identified synthetic consumption values and sample neighborhood data. It does not execute operational actions or make real utility-system changes.

## How the application works

The app starts in `lib/main.dart`, which launches `CommitDashboardApp` from `lib/app/app.dart`.

`CommitDashboardApp` applies the shared `AppTheme` and opens `DashboardPage`. `DashboardPage` maintains the selected navigation tab and switches between:

- `EnergyDashboardPage`: KPIs, forecast visualization, neighborhood filters, and capacity rankings.
- `AlertsPage`: active-alert status.
- `DecisionsPage`: recorded-decision status.
- `SettingsPage`: dashboard preferences.
- `AlertDetailPage`: details for a selected alert.

The user interface is built from Flutter widgets rather than embedded HTML or React Native components. Shared presentation is split into:

- `lib/widgets/`: cards, KPI tiles, page headers, and ranking rows.
- `lib/theme/`: shared colors and typography.
- `lib/features/`: feature-specific screens and navigation.

The neighborhood chip selection is kept with `StatefulWidget` state. The dashboard is rebuilt immediately when the selection changes. The same selection supplies synthetic historical values to `HistoricalComparisonChart`, which compares the neighborhood with the regional average across six months. Ranking rows calculate their visual color and bar width from their capacity percentage. Charts are drawn with `CustomPainter` and grid lines.

## Project structure

```text
lib/
  main.dart                         Application entry point
  app/
    app.dart                        Material app and theme configuration
  theme/
    app_theme.dart                  Shared colors and text styles
  widgets/
    app_card.dart                   Reusable card surface
    kpi_tile.dart                   Reusable KPI indicator
    page_header.dart                Shared screen header
    ranking_row.dart                Capacity-ranking row
    historical_comparison_chart.dart
                                   Neighborhood-versus-regional chart
  features/
    dashboard/
      dashboard_page.dart           Bottom navigation container
      energy_dashboard_page.dart    Main energy dashboard
    alerts/
      alerts_page.dart              Alerts screen
    decisions/
      decisions_page.dart           Decisions screen
    settings/
      settings_page.dart            Settings screen
    alert_detail/
      alert_detail_page.dart        Alert-detail screen
test/
  widget_test.dart                  Widget smoke test
windows/                            Native Windows runner
web/                                Generated web runner
```

## Requirements

- Flutter 3.50 or newer
- Dart 3.14 or newer
- Windows 11 for the Windows build
- Chrome or Edge for the web build

The Flutter SDK used for this project is installed at `C:\src\flutter`.

## Setup

From the project directory:

```powershell
C:\src\flutter\bin\flutter.bat pub get
```

Add the Flutter SDK to your user `PATH` to make `flutter` available directly:

```powershell
$flutterBin = 'C:\src\flutter\bin'
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
[Environment]::SetEnvironmentVariable('Path', "$userPath;$flutterBin", 'User')
```

Open a new terminal after changing `PATH`.

## Run the application

Run in Chrome:

```powershell
flutter run -d chrome
```

Run as a native Windows application:

```powershell
flutter run -d windows
```

An already-built Windows executable is available at:

```text
build\windows\x64\runner\Release\commit_dashboard.exe
```

## Build the application

Create a web release:

```powershell
flutter build web
```

Create a Windows release:

```powershell
flutter build windows
```

## Validate changes

Analyze Dart code:

```powershell
flutter analyze
```

Run widget tests:

```powershell
flutter test
```

## Verification status

The project has been verified to:

- Analyze with no reported issues.
- Pass the Flutter widget test.
- Build successfully for web.
- Build successfully for Windows.
