import 'package:flutter_test/flutter_test.dart';

import 'package:commit_dashboard/app/app.dart';

void main() {
  testWidgets('shows the dashboard title', (tester) async {
    await tester.pumpWidget(const CommitDashboardApp());

    expect(find.text('Painel de Energia'), findsOneWidget);
    expect(find.text('Consumo de ontem'), findsOneWidget);
  });

  testWidgets('compares the selected neighborhood historically', (tester) async {
    await tester.pumpWidget(const CommitDashboardApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('media regional'), findsWidgets);

    await tester.tap(find.text('Norte'));
    await tester.pump();

    expect(find.text('Norte x media regional'), findsOneWidget);
  });
}
