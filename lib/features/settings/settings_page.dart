import 'package:material_ui/material_ui.dart';

import '../../widgets/app_card.dart';
import '../../widgets/page_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PageHeader(
              title: 'Ajustes',
              subtitle: 'Preferencias do dashboard',
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
                      'Preferencias',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'As configuracoes disponiveis para o gestor '
                      'aparecerao aqui.',
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
