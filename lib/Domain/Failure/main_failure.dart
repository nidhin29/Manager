import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failure.freezed.dart';
@freezed
class MainFailure with _$MainFailure{
  const factory MainFailure.unexpected() = Unexpected;
  const factory MainFailure.insufficientPermission() = InsufficientPermission;
  const factory MainFailure.unableToUpdate() = UnableToUpdate;
}