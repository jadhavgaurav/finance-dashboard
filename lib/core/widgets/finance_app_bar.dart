import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FinanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FinanceAppBar({
    required this.title,
    this.actions,
    this.bottom,
    this.centerTitle = false,
    super.key,
  });

  final Widget title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: DefaultTextStyle(
        style: context.typography.title,
        child: title,
      ),
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      backgroundColor: context.colors.surface,
      surfaceTintColor: Colors.transparent, 
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
