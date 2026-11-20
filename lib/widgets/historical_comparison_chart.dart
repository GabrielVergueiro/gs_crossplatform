import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class HistoricalComparisonChart extends StatelessWidget {
  const HistoricalComparisonChart({
    required this.neighborhoodName,
    required this.neighborhoodValues,
    required this.regionalValues,
    super.key,
  });

  final String neighborhoodName;
  final List<double> neighborhoodValues;
  final List<double> regionalValues;

  @override
  Widget build(BuildContext context) {
    const periodLabels = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun'];

    return Semantics(
      label:
          'Comparacao historica de consumo. $neighborhoodName comparado com a media regional.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Historico de consumo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '$neighborhoodName x media regional',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border),
            ),
            child: CustomPaint(
              painter: _HistoricalComparisonPainter(
                neighborhoodName: neighborhoodName,
                neighborhoodValues: neighborhoodValues,
                regionalValues: regionalValues,
                periodLabels: periodLabels,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _ChartLegend(
                color: AppTheme.navy,
                label: neighborhoodName,
              ),
              const _ChartLegend(
                color: AppTheme.amber,
                label: 'Media regional',
                dashed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend({
    required this.color,
    required this.label,
    this.dashed = false,
  });

  final Color color;
  final String label;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: const Size(22, 3),
          painter: _LegendPainter(color: color, dashed: dashed),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _LegendPainter extends CustomPainter {
  const _LegendPainter({
    required this.color,
    required this.dashed,
  });

  final Color color;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    if (!dashed) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
      return;
    }

    var start = 0.0;
    while (start < size.width) {
      final end = (start + 5).clamp(0, size.width).toDouble();
      canvas.drawLine(
        Offset(start, 0),
        Offset(end, 0),
        paint,
      );
      start += 8;
    }
  }

  @override
  bool shouldRepaint(covariant _LegendPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.dashed != dashed;
  }
}

class _HistoricalComparisonPainter extends CustomPainter {
  _HistoricalComparisonPainter({
    required this.neighborhoodName,
    required this.neighborhoodValues,
    required this.regionalValues,
    required this.periodLabels,
  });

  final String neighborhoodName;
  final List<double> neighborhoodValues;
  final List<double> regionalValues;
  final List<String> periodLabels;

  @override
  void paint(Canvas canvas, Size size) {
    const leftPadding = 38.0;
    const rightPadding = 12.0;
    const topPadding = 16.0;
    const bottomPadding = 28.0;

    final chartWidth = size.width - leftPadding - rightPadding;
    final chartHeight = size.height - topPadding - bottomPadding;

    final allValues = [
      ...neighborhoodValues,
      ...regionalValues,
    ];
    final minimum = allValues.reduce((a, b) => a < b ? a : b) * 0.9;
    final maximum = allValues.reduce((a, b) => a > b ? a : b) * 1.1;

    double horizontalPosition(int index) {
      if (periodLabels.length == 1) {
        return leftPadding + chartWidth / 2;
      }
      return leftPadding + index * chartWidth / (periodLabels.length - 1);
    }

    double verticalPosition(double value) {
      final valueRatio = (value - minimum) / (maximum - minimum);
      return topPadding + chartHeight * (1 - valueRatio);
    }

    final gridPaint = Paint()
      ..color = AppTheme.border
      ..strokeWidth = 1;

    for (var row = 0; row < 4; row++) {
      final y = topPadding + chartHeight * row / 3;
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(leftPadding + chartWidth, y),
        gridPaint,
      );
    }

    const labelStyle = TextStyle(
      color: AppTheme.mutedInk,
      fontSize: 10,
    );

    for (var index = 0; index < periodLabels.length; index++) {
      final label = TextSpan(text: periodLabels[index], style: labelStyle);
      final textPainter = TextPainter(
        text: label,
        textDirection: TextDirection.ltr,
      )..layout();

      final x = horizontalPosition(index) - textPainter.width / 2;
      final y = size.height - bottomPadding + 10;
      textPainter.paint(canvas, Offset(x, y));
    }

    void drawLine(List<double> values, Color color, {bool dashed = false}) {
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      final points = <Offset>[
        for (var index = 0; index < values.length; index++)
          Offset(
            horizontalPosition(index),
            verticalPosition(values[index]),
          ),
      ];

      if (!dashed) {
        for (var index = 0; index < points.length - 1; index++) {
          canvas.drawLine(points[index], points[index + 1], linePaint);
        }
      } else {
        for (var index = 0; index < points.length - 1; index++) {
          final start = points[index];
          final end = points[index + 1];
          final distance = (end - start).distance;
          if (distance == 0) {
            continue;
          }
          final unit = (end - start) / distance;
          var traveled = 0.0;

          while (traveled < distance) {
            final segmentEnd =
                (traveled + 5).clamp(0, distance).toDouble();
            canvas.drawLine(
              start + unit * traveled,
              start + unit * segmentEnd,
              linePaint,
            );
            traveled += 9;
          }
        }
      }

      for (final point in points) {
        canvas.drawCircle(point, 3.5, Paint()..color = color);
      }
    }

    drawLine(regionalValues, AppTheme.amber, dashed: true);
    drawLine(neighborhoodValues, AppTheme.navy);
  }

  @override
  bool shouldRepaint(covariant _HistoricalComparisonPainter oldDelegate) {
    return oldDelegate.neighborhoodName != neighborhoodName ||
        oldDelegate.neighborhoodValues != neighborhoodValues ||
        oldDelegate.regionalValues != regionalValues;
  }
}
