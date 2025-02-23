import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
//import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Accounts/accounts_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AccountsService)
class AccountsRepo implements AccountsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getUserId() {
    final user = TokenManager().user;
    log(user.toString());
    return user!;
  }

  @override
  Future<Either<MainFailure, Unit>> createAccount(AccountsModel account) async {
    try {
      final userId = _getUserId();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('accounts')
          .doc(account.id)
          .set(account.toMap());
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, Unit>> ensureInitialAccount() async {
    try {
      final userId = _getUserId();
      final userAccounts = await _firestore
          .collection('users')
          .doc(userId)
          .collection('accounts')
          .get();

      if (userAccounts.docs.isEmpty) {
        final defaultAccount =
            AccountsModel(id: userId, name: "Bank", transactions: []);
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('accounts')
            .doc(defaultAccount.id)
            .set(defaultAccount.toMap());
      }
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, List<AccountsModel>>> getAccounts() async {
    try {
      final userId = _getUserId();
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('accounts')
          .get();
      final accounts = snapshot.docs
          .map((doc) => AccountsModel.fromMap(doc.data()))
          .toList();
      return right(accounts);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, Unit>> addTransaction(
      TransactionModel transaction, String accountId) async {
    try {
      final userId = _getUserId();
      final accountRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('accounts')
          .doc(accountId);
      accountRef.update({
        'transactions': FieldValue.arrayUnion([transaction.toMap()])
      });
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, Unit>> deleteTransaction(
      TransactionModel transaction, String accountId) async {
    try {
      final userId = _getUserId();
      final accountRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('accounts')
          .doc(accountId);
      accountRef.update({
        'transactions': FieldValue.arrayRemove([transaction.toMap()])
      });
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }
  
  @override
  Future<BudgetModel> getBudget() async{      
    final prefs = await SharedPreferences.getInstance();
    return BudgetModel(
      amount: prefs.getInt('Amount') ?? -1,
      date: DateTime.parse(prefs.getString('Date') ?? DateTime.now().toString()),
      frequency: prefs.getString('Frequency') ?? ''
    );
  }
}
