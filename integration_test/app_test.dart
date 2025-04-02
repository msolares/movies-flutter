import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:boardgamesmsf/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Carga y muestra la lista de películas correctamente', (WidgetTester tester) async {

    app.main();
    await tester.pumpAndSettle();

    // Verificar que la pantalla de películas está presente
    expect(find.byType(GridView), findsOneWidget);

    // Esperar a que se carguen los datos de películas
    await tester.pumpAndSettle();

    // Verificar que al menos una película se muestra en la UI
    expect(find.byType(InkWell), findsWidgets);
  });
}