// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:manager/Application/Accounts/accounts_cubit.dart' as _i322;
import 'package:manager/Application/Accounts/Budget/budget_cubit.dart' as _i722;
import 'package:manager/Application/Accounts/Create/accountscreate_cubit.dart'
    as _i381;
import 'package:manager/Application/Accounts/Transaction/Create/transactioncreate_cubit.dart'
    as _i45;
import 'package:manager/Application/Category/category_cubit.dart' as _i1041;
import 'package:manager/Application/Category/Create/create_cubit.dart' as _i137;
import 'package:manager/Application/SignIn/signincubit_cubit.dart' as _i996;
import 'package:manager/Domain/Accounts/accounts_service.dart' as _i694;
import 'package:manager/Domain/Accounts/Category/category_service.dart'
    as _i261;
import 'package:manager/Domain/SignIn/sign_in_service.dart' as _i126;
import 'package:manager/Infrastructure/Accounts/accounts_repo.dart' as _i1035;
import 'package:manager/Infrastructure/Category/category_repo.dart' as _i190;
import 'package:manager/Infrastructure/core/firebase_injectable_module.dart'
    as _i796;
import 'package:manager/Infrastructure/SignIn/sign_in_repo.dart' as _i371;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i116.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i59.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseInjectableModule.firebasefirestore);
    gh.lazySingleton<_i261.CategoryService>(() => _i190.CategoryRepo());
    gh.lazySingleton<_i694.AccountsService>(() => _i1035.AccountsRepo());
    gh.factory<_i322.AccountsCubit>(
        () => _i322.AccountsCubit(gh<_i694.AccountsService>()));
    gh.factory<_i381.AccountscreateCubit>(
        () => _i381.AccountscreateCubit(gh<_i694.AccountsService>()));
    gh.factory<_i45.TransactioncreateCubit>(
        () => _i45.TransactioncreateCubit(gh<_i694.AccountsService>()));
    gh.factory<_i722.BudgetCubit>(
        () => _i722.BudgetCubit(gh<_i694.AccountsService>()));
    gh.factory<_i1041.CategoryCubit>(
        () => _i1041.CategoryCubit(gh<_i261.CategoryService>()));
    gh.factory<_i137.CreateCubit>(
        () => _i137.CreateCubit(gh<_i261.CategoryService>()));
    gh.lazySingleton<_i126.SignInService>(() => _i371.SignInRepo(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
        ));
    gh.factory<_i996.SignInCubit>(
        () => _i996.SignInCubit(gh<_i126.SignInService>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i796.FirebaseInjectableModule {}
