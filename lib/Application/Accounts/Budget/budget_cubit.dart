import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Accounts/accounts_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'budget_state.dart';
part 'budget_cubit.freezed.dart';

@injectable
class BudgetCubit extends Cubit<BudgetState> {
  final AccountsService _accountsService;
  BudgetCubit(this._accountsService) : super(BudgetState.initial());

  Future<void> getBudget() async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));

    final accounts = await _accountsService.getAccounts();
    accounts.fold(
        (l) => {
              emit(state.copyWith(
                  isLoading: false, failureOrSuccessOption: none()))
            }, (r) async {
      final budget = await _accountsService.getBudget();
      log(budget.frequency);
      if (budget.amount == -1 || budget.frequency.isEmpty) {
        emit(state.copyWith(
            isLoading: false, failureOrSuccessOption: some(budget), total: 0));
      } else {
           final budgetStartDate = budget.date.add(const Duration(seconds: 1));

      final budgetEndDate =
          _calculateBudgetEndDate(budgetStartDate, budget.frequency);

      // Filter expense transactions that occurred within the budget period
      final transactions = r
          .expand((account) => account.transactions)
          .where((transaction) =>
              transaction.date.isAfter(budgetStartDate) &&
              transaction.date.isBefore(budgetEndDate) &&
              transaction.type == 'expense')
          .toList();

      // Calculate the total amount of these expense transactions
      final totalAmount = transactions.fold(
          0.0,
          (sum, transaction) =>
              sum + double.parse(transaction.amount.toString()));

      emit(state.copyWith(
        isLoading: false,
        failureOrSuccessOption: some(budget),
        total: totalAmount.toInt(),
      ));
      }
   
    });
  }

  DateTime _calculateBudgetEndDate(DateTime startDate, String frequency) {
    log('Frequency: $frequency');
    switch (frequency.toLowerCase()) {
      case 'daily':
        return startDate.add(const Duration(days: 1));
      case 'weekly':
        return startDate.add(const Duration(days: 7));
      case 'monthly':
        return DateTime(startDate.year, startDate.month + 1, startDate.day);
      case 'yearly':
        return DateTime(startDate.year + 1, startDate.month, startDate.day);
      default:
        throw ArgumentError('Invalid budget frequency: $frequency');
    }
  }

  Future<void> deleteBudget() async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('Amount');
    await prefs.remove('Date');
    await prefs.remove('Frequency');

    emit(state.copyWith(
      isLoading: false,
      failureOrSuccessOption:
          some(BudgetModel(amount: -1, date: DateTime.now(), frequency: '')),
    ));
  }
}
