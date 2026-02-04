import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/app_text_field.dart';
import 'package:agency_finance/core/widgets/finance_app_bar.dart';
import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:agency_finance/features/transactions/presentation/controllers/transaction_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTransactionScreen extends HookConsumerWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionFormProvider);
    final controller = ref.read(transactionFormProvider.notifier);
    
    // Form Controllers
    final amountController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final referenceController = useTextEditingController();
    final partyController = useTextEditingController();

    return Scaffold(
      appBar: const FinanceAppBar(title: Text('New Transaction')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: state.currentStep,
        onStepContinue: controller.nextStep,
        onStepCancel: controller.previousStep,
        onStepTapped: controller.setStep,
        controlsBuilder: (context, details) {
          // Custom controls at bottom
          return const SizedBox.shrink(); 
        },
        steps: [
          Step(
            title: const Text('Basics'),
            isActive: state.currentStep >= 0,
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _DirectionSelector(
                        selected: state.direction,
                        onChanged: controller.setDirection,
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                AppTextField(label: 'Amount (INR)', controller: amountController, keyboardType: TextInputType.number),
                const Gap(16),
                AppTextField(label: 'Date', hint: DateTime.now().toString().split(' ')[0], readOnly: true, suffixIcon: const Icon(Icons.calendar_today)),
                const Gap(16),
                 Text('Payment Mode', style: context.typography.caption),
                 const Gap(8),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: PaymentMode.values.map((mode) {
                       return Padding(
                         padding: const EdgeInsets.only(right: 8),
                         child: ChoiceChip(
                           label: Text(mode.label),
                           selected: state.selectedMode == mode,
                           onSelected: (val) {
                             if (val) controller.setMode(mode);
                           },
                         ),
                       );
                     }).toList(),
                   ),
                 ),
              ],
            ),
          ),
          Step(
            title: const Text('Details'),
            isActive: state.currentStep >= 1,
            content: Column(
              children: [
                AppTextField(label: state.direction == TransactionDirection.incoming ? 'Payer' : 'Payee/Vendor', controller: partyController),
                const Gap(16),
                if (state.selectedMode == PaymentMode.rtgs || state.selectedMode == PaymentMode.neft) 
                  AppTextField(label: 'UTR / Reference', controller: referenceController),
                if (state.selectedMode == PaymentMode.cheque)
                  AppTextField(label: 'Cheque Number', controller: referenceController),
                  
                const Gap(16),
                AppTextField(label: 'Description', controller: descriptionController, maxLines: 3),
              ],
            ),
          ),
          Step(
            title: const Text('Review'),
            isActive: state.currentStep >= 2,
            content: const Column(
              children: [
                // Summary Logic Here
                Text('Summary Review UI Placeholder'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: context.colors.surface, border: Border(top: BorderSide(color: context.colors.border))),
        child: Row(
          children: [
            if (state.currentStep > 0)
              Expanded(child: SecondaryButton(label: 'Back', onPressed: controller.previousStep))
            else
              const Spacer(),
            const Gap(16),
            Expanded(
              child: PrimaryButton(
                label: state.currentStep == 2 ? 'Submit' : 'Next',
                isLoading: state.isLoading,
                onPressed: () {
                  if (state.currentStep == 0) {
                     // Step 0 Validation
                     if (amountController.text.isEmpty || double.tryParse(amountController.text) == null) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Amount')));
                       return;
                     }
                  }
                  if (state.currentStep == 1) {
                    if (partyController.text.isEmpty) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Party Name Required')));
                       return;
                    }
                  }
                  
                  if (state.currentStep == 2) {
                    controller.submit().then((_) {
                       Navigator.pop(context); // Go back after submit
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaction Created')));
                    });
                  } else {
                    controller.nextStep();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionSelector extends StatelessWidget {
  const _DirectionSelector({required this.selected, required this.onChanged});
  final TransactionDirection selected;
  final ValueChanged<TransactionDirection> onChanged;

  @override
  Widget build(BuildContext context) {
    // Simple toggle
    return SegmentedButton<TransactionDirection>(
      segments: const [
        ButtonSegment(value: TransactionDirection.incoming, label: Text('Cash In'), icon: Icon(Icons.arrow_downward)),
        ButtonSegment(value: TransactionDirection.outgoing, label: Text('Cash Out'), icon: Icon(Icons.arrow_upward)),
      ],
      selected: {selected},
      onSelectionChanged: (Set<TransactionDirection> newSelection) {
        onChanged(newSelection.first);
      },
    );
  }
}
