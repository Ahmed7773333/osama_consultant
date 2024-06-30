import 'package:get_it/get_it.dart';
import 'package:osama_consultant/features/Registraion/data/datasources/auth_remote_ds_impl.dart';
import 'package:osama_consultant/features/Registraion/domain/usecases/sign_in_usecase.dart';
import 'package:osama_consultant/features/Registraion/domain/usecases/sign_up_usecase.dart';
import 'package:osama_consultant/features/Registraion/presentation/bloc/registraion_bloc.dart';

import '../../features/Registraion/data/repositories/auth_repo_impl.dart';
import '../api/api_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RegistraionBloc(sl(), sl()));

  // Use Cases

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // Repository
  sl.registerLazySingleton(() => AuthRepoImpl(sl()));

  // Data sources
  sl.registerLazySingleton(() => AuthRemoteDSImpl(sl()));

  // Core
  sl.registerLazySingleton(() => ApiManager());
}
