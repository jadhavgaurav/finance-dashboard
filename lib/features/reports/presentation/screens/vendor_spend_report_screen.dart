import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VendorSpendReportScreen extends StatelessWidget {
  const VendorSpendReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Vendor Spend')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const Gap(16),
        itemBuilder: (context, index) {
          final vendors = ['Tech Solutions', 'Office Depot', 'Amazon Business', 'Cloud Flare', 'Local Rental'];
          final spends = ['1,20,000', '45,000', '12,500', '8,000', '60,000'];
          
          return FinanceCard(
            body: Row(
              children: [
                CircleAvatar(child: Text('${index + 1}')),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vendors[index], style: typography.title),
                      const Gap(4),
                      LinearProgressIndicator(
                        value: (5 - index) / 5,
                        backgroundColor: context.colors.border,
                        color: context.colors.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Text('₹${spends[index]}', style: typography.title),
              ],
            ),
          );
        },
      ),
    );
  }
}
