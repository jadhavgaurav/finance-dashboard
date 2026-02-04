import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/app_text_field.dart';
import 'package:agency_finance/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final currencyController = useTextEditingController(text: 'INR');
    final fiscalController = useTextEditingController(text: 'April');
    
    final isLoading = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    
    final colors = context.colors;
    final typography = context.typography;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(48),
              Text('Welcome!', style: typography.display),
              const Gap(8),
              Text("Let's set up your company profile.", style: typography.subtitle.copyWith(color: colors.textSecondary)),
              const Gap(48),
              
              AppTextField(label: 'Company Name', controller: nameController, hint: 'Acme Corp'),
              const Gap(16),
              AppTextField(label: 'Base Currency', controller: currencyController),
              const Gap(16),
              // In real app, make this a dropdown
              AppTextField(label: 'Fiscal Year Start Month', controller: fiscalController, hint: 'April'), 
              
              const Spacer(),
              PrimaryButton(
                label: 'Get Started', 
                isLoading: isLoading,
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    controller.completeOnboarding(
                      companyName: nameController.text,
                      currency: currencyController.text,
                      fiscalYearStart: fiscalController.text,
                    );
                  }
                },
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}
