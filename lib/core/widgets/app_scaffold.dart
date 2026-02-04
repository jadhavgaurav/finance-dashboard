import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.withSafeArea = true,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool withSafeArea;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    // Set status bar color
    // SystemChrome logic is usually largely handled by AppBar but can include here if needed
    
    Widget content = body;
    if (withSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: colors.background,
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
