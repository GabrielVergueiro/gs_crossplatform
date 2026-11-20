import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

enum KpiTone {
  neutral,
  warning,
  critical,
  success,
}

class KpiTile extends StatelessWidget {
  const KpiTile({
    required this.label,
    required this.value,
    required this.detail,
    this.unit,
    this.tone = KpiTone.neutral,
    super.key,
  });

  final String label;
  final String value;
  final String detail;
  final String? unit;
  final KpiTone tone;

  Color get valueColor {
    switch (tone) {
      case KpiTone.warning:
        return AppTheme.warning;
      case KpiTone.critical:
        return AppTheme.critical;
      case KpiTone.success:
        return AppTheme.success;
      case KpiTone.neutral:
        return AppTheme.ink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: valueColor,
                      fontSize: 28,
                    ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(unit!, style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(detail, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
