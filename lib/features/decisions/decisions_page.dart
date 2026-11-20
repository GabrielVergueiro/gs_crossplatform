import 'package:material_ui/material_ui.dart';

import '../../widgets/app_card.dart';
import '../../widgets/page_header.dart';

class DecisionsPage extends StatelessWidget {
  const DecisionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: PageHeader(
              title: 'Decisoes',
              subtitle: 'Historico das acoes registradas',
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
                      'Nenhuma decisao registrada',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'As decisoes aprovadas por gestores ficarao '
                      'registradas nesta tela.',
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
