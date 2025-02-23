import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Domain/Accounts/Category/category_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';

@LazySingleton(as: CategoryService)
class CategoryRepo implements CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getUserId() {
    final user = TokenManager().user;
    log(user.toString());
    return user!;
  }

  @override
  Future<Either<MainFailure, Unit>> createCategory(
      CategoryModel category) async {
    try {
      final userId = _getUserId();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(category.id)
          .set(category.toMap());
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, Unit>> deleteCategory(
      CategoryModel category) async {
    try {
      final userId = _getUserId();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(category.id)
          .delete();
      return right(unit);
    } catch (e) {
      return left(const MainFailure.unexpected());
    }
  }

  @override
  Future<Either<MainFailure, List<CategoryModel>>> getCategories() async {
    try {
      final userId = _getUserId();
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .get();

      final categories = snapshot.docs.map((doc) {
        return CategoryModel.fromMap(doc.data());
      }).toList();

      return right(categories);
    } catch (e) {
      log(e.toString());
      return left(const MainFailure.unexpected());
    }
  }
}
