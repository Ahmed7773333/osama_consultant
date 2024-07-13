import 'package:get_it/get_it.dart';
import 'package:osama_consul/features/Registraion/domain/usecases/sign_in_google_usercase.dart';

import '../../features/Registraion/data/datasources/auth_remote_ds_impl.dart';
import '../../features/Registraion/data/repositories/auth_repo_impl.dart';
import '../../features/Registraion/domain/usecases/sign_in_usecase.dart';
import '../../features/Registraion/domain/usecases/sign_up_usecase.dart';
import '../../features/Registraion/presentation/bloc/registraion_bloc.dart';
import '../api/api_manager.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Core
  sl.registerLazySingleton<ApiManager>(() => ApiManager());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDSImpl>(
      () => AuthRemoteDSImpl(sl<ApiManager>()));

  // Repository
  sl.registerLazySingleton<AuthRepoImpl>(
      () => AuthRepoImpl(sl<AuthRemoteDSImpl>()));

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepoImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepoImpl>()));
  sl.registerLazySingleton(() => SignInGoogleUseCase(sl<AuthRepoImpl>()));
  // Bloc
  sl.registerFactory(() => RegistraionBloc(
      sl<SignInUseCase>(), sl<SignUpUseCase>(), sl<SignInGoogleUseCase>()));
}
