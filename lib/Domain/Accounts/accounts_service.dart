import 'package:dartz/dartz.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Failure/main_failure.dart';

abstract class AccountsService {
  Future<Either<MainFailure, Unit>> createAccount(AccountsModel account);
  Future<Either<MainFailure, List<AccountsModel>>> getAccounts();
  Future<Either<MainFailure,Unit>> ensureInitialAccount();
   Future<Either<MainFailure,Unit>> addTransaction(TransactionModel transaction,String accountId);
   Future<Either<MainFailure,Unit>> deleteTransaction(TransactionModel transaction, String accountId);
   Future<BudgetModel> getBudget();
}