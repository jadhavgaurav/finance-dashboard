import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/core/widgets/finance_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryBreakdownScreen extends StatelessWidget {
  const CategoryBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('Category Breakdown')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FinanceCard(
              header: Text('Expense Categories', style: typography.title),
              body: const Column(
                children: [
                   Gap(100),
                   Center(child: Text('Pie Chart Placeholder')),
                   Gap(100),
                ],
              ),
            ),
            const Gap(16),
            ...List.generate(4, (index) {
              final categories = ['IT Services', 'Rent', 'Payroll', 'Marketing'];
              final amounts = ['₹85,000', '₹60,000', '₹2,50,000', '₹35,000'];
              final percentages = ['20%', '15%', '55%', '10%'];
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FinanceCard(
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(categories[index], style: typography.title),
                          Text(percentages[index], style: typography.caption),
                        ],
                      ),
                      Text(amounts[index], style: typography.title),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
