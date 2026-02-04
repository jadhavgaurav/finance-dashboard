import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FinanceCard extends StatelessWidget {
  const FinanceCard({
    this.header,
    this.body,
    this.footer,
    this.padding,
    this.onTap,
    super.key,
  });

  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) ...[
                header!,
                const SizedBox(height: 12),
              ],
              if (body != null) body!,
              if (footer != null) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
