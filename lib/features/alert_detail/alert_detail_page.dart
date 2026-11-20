import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_card.dart';
import '../../widgets/page_header.dart';

class AlertDetailPage extends StatelessWidget {
  const AlertDetailPage({
    required this.alertId,
    super.key,
  });

  final String alertId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: PageHeader(
              title: 'Detalhe do alerta',
              subtitle: 'Informacoes do alerta selecionado',
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alerta $alertId',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Consulte os dados de consumo e previsao antes '
                      'de registrar uma decisao.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.navy,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
        tooltip: 'Voltar',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
