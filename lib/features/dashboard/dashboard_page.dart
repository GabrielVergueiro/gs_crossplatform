import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';
import '../alerts/alerts_page.dart';
import '../decisions/decisions_page.dart';
import '../settings/settings_page.dart';
import 'energy_dashboard_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentTab = 0;

  final List<Widget> pages = const [
    EnergyDashboardPage(),
    AlertsPage(),
    DecisionsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab,
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.navy.withValues(alpha: 0.10),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            currentTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.speed_outlined),
            selectedIcon: Icon(Icons.speed),
            label: 'Painel',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alertas',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Decisoes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
