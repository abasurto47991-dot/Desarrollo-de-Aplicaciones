import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('shows the evidence registration screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiAplicacion());

    expect(find.text('Registro de evidencias de campo'), findsOneWidget);
    expect(find.text('Registrar Evidencia'), findsOneWidget);
  });
}
