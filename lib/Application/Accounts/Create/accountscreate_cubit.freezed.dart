// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accountscreate_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountscreateState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingForBudget => throw _privateConstructorUsedError;
  Option<BudgetModel> get failureOrSuccessOptionforBudget =>
      throw _privateConstructorUsedError;
  BudgetModel get budget => throw _privateConstructorUsedError;
  Option<Either<MainFailure, List<AccountsModel>>> get failureOrSuccessOption =>
      throw _privateConstructorUsedError;
  List<AccountsModel> get accounts => throw _privateConstructorUsedError;

  /// Create a copy of AccountscreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountscreateStateCopyWith<AccountscreateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountscreateStateCopyWith<$Res> {
  factory $AccountscreateStateCopyWith(
          AccountscreateState value, $Res Function(AccountscreateState) then) =
      _$AccountscreateStateCopyWithImpl<$Res, AccountscreateState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingForBudget,
      Option<BudgetModel> failureOrSuccessOptionforBudget,
      BudgetModel budget,
      Option<Either<MainFailure, List<AccountsModel>>> failureOrSuccessOption,
      List<AccountsModel> accounts});
}

/// @nodoc
class _$AccountscreateStateCopyWithImpl<$Res, $Val extends AccountscreateState>
    implements $AccountscreateStateCopyWith<$Res> {
  _$AccountscreateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountscreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingForBudget = null,
    Object? failureOrSuccessOptionforBudget = null,
    Object? budget = null,
    Object? failureOrSuccessOption = null,
    Object? accounts = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingForBudget: null == isLoadingForBudget
          ? _value.isLoadingForBudget
          : isLoadingForBudget // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccessOptionforBudget: null == failureOrSuccessOptionforBudget
          ? _value.failureOrSuccessOptionforBudget
          : failureOrSuccessOptionforBudget // ignore: cast_nullable_to_non_nullable
              as Option<BudgetModel>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetModel,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _value.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, List<AccountsModel>>>,
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountsModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $AccountscreateStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingForBudget,
      Option<BudgetModel> failureOrSuccessOptionforBudget,
      BudgetModel budget,
      Option<Either<MainFailure, List<AccountsModel>>> failureOrSuccessOption,
      List<AccountsModel> accounts});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AccountscreateStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountscreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingForBudget = null,
    Object? failureOrSuccessOptionforBudget = null,
    Object? budget = null,
    Object? failureOrSuccessOption = null,
    Object? accounts = null,
  }) {
    return _then(_$InitialImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingForBudget: null == isLoadingForBudget
          ? _value.isLoadingForBudget
          : isLoadingForBudget // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccessOptionforBudget: null == failureOrSuccessOptionforBudget
          ? _value.failureOrSuccessOptionforBudget
          : failureOrSuccessOptionforBudget // ignore: cast_nullable_to_non_nullable
              as Option<BudgetModel>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as BudgetModel,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _value.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, List<AccountsModel>>>,
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountsModel>,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.isLoading,
      required this.isLoadingForBudget,
      required this.failureOrSuccessOptionforBudget,
      required this.budget,
      required this.failureOrSuccessOption,
      required final List<AccountsModel> accounts})
      : _accounts = accounts;

  @override
  final bool isLoading;
  @override
  final bool isLoadingForBudget;
  @override
  final Option<BudgetModel> failureOrSuccessOptionforBudget;
  @override
  final BudgetModel budget;
  @override
  final Option<Either<MainFailure, List<AccountsModel>>> failureOrSuccessOption;
  final List<AccountsModel> _accounts;
  @override
  List<AccountsModel> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  String toString() {
    return 'AccountscreateState(isLoading: $isLoading, isLoadingForBudget: $isLoadingForBudget, failureOrSuccessOptionforBudget: $failureOrSuccessOptionforBudget, budget: $budget, failureOrSuccessOption: $failureOrSuccessOption, accounts: $accounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingForBudget, isLoadingForBudget) ||
                other.isLoadingForBudget == isLoadingForBudget) &&
            (identical(other.failureOrSuccessOptionforBudget,
                    failureOrSuccessOptionforBudget) ||
                other.failureOrSuccessOptionforBudget ==
                    failureOrSuccessOptionforBudget) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.failureOrSuccessOption, failureOrSuccessOption) ||
                other.failureOrSuccessOption == failureOrSuccessOption) &&
            const DeepCollectionEquality().equals(other._accounts, _accounts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingForBudget,
      failureOrSuccessOptionforBudget,
      budget,
      failureOrSuccessOption,
      const DeepCollectionEquality().hash(_accounts));

  /// Create a copy of AccountscreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements AccountscreateState {
  const factory _Initial(
      {required final bool isLoading,
      required final bool isLoadingForBudget,
      required final Option<BudgetModel> failureOrSuccessOptionforBudget,
      required final BudgetModel budget,
      required final Option<Either<MainFailure, List<AccountsModel>>>
          failureOrSuccessOption,
      required final List<AccountsModel> accounts}) = _$InitialImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingForBudget;
  @override
  Option<BudgetModel> get failureOrSuccessOptionforBudget;
  @override
  BudgetModel get budget;
  @override
  Option<Either<MainFailure, List<AccountsModel>>> get failureOrSuccessOption;
  @override
  List<AccountsModel> get accounts;

  /// Create a copy of AccountscreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
