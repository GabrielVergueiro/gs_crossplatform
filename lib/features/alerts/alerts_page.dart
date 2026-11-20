import 'package:material_ui/material_ui.dart';

import '../../widgets/app_card.dart';
import '../../widgets/page_header.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PageHeader(
              title: 'Alertas',
              subtitle: 'Notificacoes que precisam de atencao',
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nenhum alerta ativo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Os alertas gerados pelas previsoes aparecerao aqui.',
                      style: TextStyle(color: Color(0xFF64788F)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
