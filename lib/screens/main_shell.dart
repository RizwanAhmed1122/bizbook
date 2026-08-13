import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state_provider.dart';
import '../providers/theme_provider.dart';
import 'dashboard_screen.dart';
import 'products_screen.dart';
import 'customers_screen.dart';
import 'sales_screen.dart';
import 'purchases_screen.dart';
import 'payments_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ProductsScreen(),
    CustomersScreen(),
    SalesScreen(),
    PurchasesScreen(),
    PaymentsScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
    NavigationDestination(icon: Icon(Icons.inventory_2_rounded), label: 'Products'),
    NavigationDestination(icon: Icon(Icons.people_alt_rounded), label: 'Customers'),
    NavigationDestination(icon: Icon(Icons.point_of_sale_rounded), label: 'Sales'),
    NavigationDestination(icon: Icon(Icons.shopping_cart_rounded), label: 'Purchases'),
    NavigationDestination(icon: Icon(Icons.payments_rounded), label: 'Payments'),
    NavigationDestination(icon: Icon(Icons.query_stats_rounded), label: 'Reports'),
    NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BizBook'),
        actions: [
          Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
          IconButton(
            onPressed: () {
              context.read<AppStateProvider>().logout();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          Navigator.of(context).pop();
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 18, 16, 10),
            child: Text('BizBook Workspace', style: Theme.of(context).textTheme.titleMedium),
          ),
          ..._destinations.asMap().entries.map((entry) {
            final index = entry.key;
            final destination = entry.value;
            return NavigationDrawerDestination(
              icon: destination.icon,
              label: Text(destination.label),
            );
          }).toList(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Divider(color: colorScheme.outlineVariant),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: _destinations,
      ),
    );
  }
}
