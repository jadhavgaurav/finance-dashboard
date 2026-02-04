import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:agency_finance/core/widgets/app_text_field.dart';
import 'package:agency_finance/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: 'demo@agency.com'); // Pre-fill for ease
    final passwordController = useTextEditingController(text: 'password');
    final authState = ref.watch(authControllerProvider);

    // Listen to error states
    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (prev, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${next.error}')),
          );
        }
      },
    );

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Finance App',
                  style: context.typography.display.copyWith(color: context.colors.accent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Agency Operations Platform',
                  style: context.typography.subtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                AppTextField(
                  label: 'Email',
                  controller: emailController,
                  hint: 'Enter your email',
                  validator: (val) => (val == null || !val.contains('@')) ? 'Invalid email' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  hint: 'Enter your password',
                  validator: (val) => (val == null || val.length < 6) ? 'Password too short' : null,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Login',
                  isLoading: authState.isLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(authControllerProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                    }
                  },
                ),
              const SizedBox(height: 16),
              SecondaryButton(
                label: 'Forgot Password?',
                onPressed: () {
                  // TODO: Implement forgot password
                },
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
