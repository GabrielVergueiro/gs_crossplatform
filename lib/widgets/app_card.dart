import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: child,
    );
  }
}
