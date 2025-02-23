import 'package:dartz/dartz.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Domain/Failure/main_failure.dart';

abstract class CategoryService {
  Future<Either<MainFailure, Unit>> createCategory(CategoryModel category);
  Future<Either<MainFailure, Unit>> deleteCategory(CategoryModel category);
  Future<Either<MainFailure, List<CategoryModel>>> getCategories();
}