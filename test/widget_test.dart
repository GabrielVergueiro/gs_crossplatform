import 'package:flutter_test/flutter_test.dart';

import 'package:commit_dashboard/app/app.dart';

void main() {
  testWidgets('shows the dashboard title', (tester) async {
    await tester.pumpWidget(const CommitDashboardApp());

    expect(find.text('Painel de Energia'), findsOneWidget);
    expect(find.text('Consumo de ontem'), findsOneWidget);
  });
}
