import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Core/Injectable/injectable.config.dart';

GetIt getIt = GetIt.instance;
@InjectableInit()
Future<void> configureInjection(String env) async {
  GetItInjectableX(getIt).init(environment: env);
}
