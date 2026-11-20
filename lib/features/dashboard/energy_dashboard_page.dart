import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_card.dart';
import '../../widgets/kpi_tile.dart';
import '../../widgets/page_header.dart';
import '../../widgets/ranking_row.dart';
import '../../widgets/historical_comparison_chart.dart';
import '../alert_detail/alert_detail_page.dart';

class EnergyDashboardPage extends StatefulWidget {
  const EnergyDashboardPage({super.key});

  @override
  State<EnergyDashboardPage> createState() => _EnergyDashboardPageState();
}

class _EnergyDashboardPageState extends State<EnergyDashboardPage> {
  String selectedNeighborhood = 'Todos';

  final List<String> neighborhoods = const [
    'Todos',
    'Centro',
    'Norte',
    'Sul',
  ];

  final Map<String, List<double>> historicalNeighborhoodValues =
      const {
        'Todos': [1180, 1210, 1195, 1260, 1248, 1290],
        'Centro': [420, 438, 431, 455, 448, 470],
        'Norte': [360, 352, 365, 378, 390, 396],
        'Sul': [400, 420, 399, 427, 410, 424],
      };

  static const List<double> regionalHistoricalValues =
      [1120, 1145, 1138, 1180, 1168, 1210];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Painel de Energia',
                subtitle: 'Consumo e demanda por bairro',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final twoColumns = constraints.maxWidth >= 640;

                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: twoColumns ? 2 : 1,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: twoColumns ? 2.1 : 2.8,
                        children: const [
                          KpiTile(
                            label: 'Consumo de ontem',
                            value: '12.480',
                            unit: 'MWh',
                            detail: '+2,4% vs media de 7 dias',
                          ),
                          KpiTile(
                            label: 'Alertas ativos',
                            value: '3',
                            detail: '1 critico',
                            tone: KpiTone.warning,
                          ),
                          KpiTile(
                            label: 'Pico previsto',
                            value: '13.220',
                            unit: 'MWh',
                            detail: 'Capacidade 14.000 MWh',
                          ),
                          KpiTile(
                            label: 'Maxima prevista',
                            value: '34',
                            unit: '°C',
                            detail: 'Fonte: Open-Meteo',
                            tone: KpiTone.warning,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consumo diario e previsao',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: neighborhoods.map((neighborhood) {
                              final selected =
                                  selectedNeighborhood == neighborhood;

                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(neighborhood),
                                  selected: selected,
                                  onSelected: (_) {
                                    setState(() {
                                      selectedNeighborhood = neighborhood;
                                    });
                                  },
                                  selectedColor: AppTheme.navy,
                                  labelStyle: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : AppTheme.ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
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
                            painter: _ConsumptionChartPainter(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Unidade: MWh/dia. Dados de consumo sinteticos.',
                          style: TextStyle(
                            color: AppTheme.mutedInk,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: HistoricalComparisonChart(
                      neighborhoodName: selectedNeighborhood,
                      neighborhoodValues:
                          historicalNeighborhoodValues[selectedNeighborhood] ??
                              historicalNeighborhoodValues['Todos']!,
                      regionalValues: regionalHistoricalValues,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pico previsto × capacidade',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Maior consumo previsto nos proximos 4 dias.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        RankingRow(
                          name: 'Centro',
                          percentage: 96,
                          onTap: () => openAlert(context, 'centro'),
                        ),
                        RankingRow(
                          name: 'Norte',
                          percentage: 88,
                          onTap: () => openAlert(context, 'norte'),
                        ),
                        RankingRow(
                          name: 'Sul',
                          percentage: 76,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Apoio a decisao: previsoes sao estimativas. '
                    'Nenhuma acao executada automaticamente.',
                    style: TextStyle(
                      color: AppTheme.mutedInk,
                      fontSize: 13,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openAlert(BuildContext context, String alertId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => AlertDetailPage(alertId: alertId),
      ),
    );
  }
}

class _ConsumptionChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppTheme.border
      ..strokeWidth = 1;

    for (var row = 0; row < 5; row++) {
      final y = size.height * row / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = <Offset>[
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.25, size.height * 0.58),
      Offset(size.width * 0.50, size.height * 0.64),
      Offset(size.width * 0.75, size.height * 0.38),
      Offset(size.width, size.height * 0.48),
    ];

    final linePaint = Paint()
      ..color = AppTheme.navy
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (var index = 0; index < points.length - 1; index++) {
      canvas.drawLine(points[index], points[index + 1], linePaint);
    }

    final forecastPaint = Paint()
      ..color = AppTheme.amber
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      points.last,
      Offset(size.width, size.height * 0.48),
      forecastPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
