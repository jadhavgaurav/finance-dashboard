import 'package:agency_finance/domain/enums/transaction_enums.dart';
import 'package:flutter_riverpod/legacy.dart';

class TransactionFormState {

  const TransactionFormState({
    this.currentStep = 0,
    this.selectedMode = PaymentMode.rtgs, // Default
    this.direction = TransactionDirection.outgoing,
    this.isLoading = false,
  });
  final int currentStep;
  final PaymentMode selectedMode;
  final TransactionDirection direction;
  final bool isLoading;

  TransactionFormState copyWith({
    int? currentStep,
    PaymentMode? selectedMode,
    TransactionDirection? direction,
    bool? isLoading,
  }) {
    return TransactionFormState(
      currentStep: currentStep ?? this.currentStep,
      selectedMode: selectedMode ?? this.selectedMode,
      direction: direction ?? this.direction,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TransactionFormController extends StateNotifier<TransactionFormState> {
  TransactionFormController() : super(const TransactionFormState());

  void setStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setMode(PaymentMode mode) {
    state = state.copyWith(selectedMode: mode);
  }

  void setDirection(TransactionDirection direction) {
    state = state.copyWith(direction: direction);
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true);
    // Simulate submission
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isLoading: false);
  }
}

final StateNotifierProvider<TransactionFormController, TransactionFormState> transactionFormProvider = StateNotifierProvider.autoDispose<TransactionFormController, TransactionFormState>((ref) {
  return TransactionFormController();
});
