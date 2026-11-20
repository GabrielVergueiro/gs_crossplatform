import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class RankingRow extends StatelessWidget {
  const RankingRow({
    required this.name,
    required this.percentage,
    required this.onTap,
    super.key,
  });

  final String name;
  final int percentage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color barColor = percentage >= 100
        ? AppTheme.critical
        : percentage >= 92
            ? AppTheme.warning
            : AppTheme.success;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '$percentage%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: barColor,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: (percentage / 100).clamp(0, 1).toDouble(),
                minHeight: 10,
                color: barColor,
                backgroundColor: AppTheme.border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
