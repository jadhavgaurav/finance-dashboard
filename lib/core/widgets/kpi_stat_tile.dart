import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class KPIStatTile extends StatelessWidget {
  const KPIStatTile({
    required this.label,
    required this.value,
    required this.icon,
    this.trend,
    this.isPositive,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? trend;
  final bool? isPositive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: colors.textSecondary, size: 20),
                  if (trend != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (isPositive ?? true)
                            ? colors.success.withOpacity(0.1)
                            : colors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        trend!,
                        style: typography.caption.copyWith(
                          color: (isPositive ?? true) ? colors.success : colors.error,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: typography.title.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: typography.caption.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
