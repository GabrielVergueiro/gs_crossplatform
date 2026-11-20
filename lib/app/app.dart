import 'package:material_ui/material_ui.dart';

import '../features/dashboard/dashboard_page.dart';
import '../theme/app_theme.dart';

class CommitDashboardApp extends StatelessWidget {
  const CommitDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard de Energia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const DashboardPage(),
    );
  }
}
