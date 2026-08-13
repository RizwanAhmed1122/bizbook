import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bizzbook_app/providers/app_state_provider.dart';
import 'package:bizzbook_app/providers/theme_provider.dart';
import 'package:bizzbook_app/screens/dashboard_screen.dart';

void main() {
  testWidgets('renders dashboard summary cards and theme toggle', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppStateProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    expect(find.text('Revenue'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });
}
