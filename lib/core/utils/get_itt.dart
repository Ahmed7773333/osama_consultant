import 'package:get_it/get_it.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/general/Registraion/domain/usecases/forget_password.dart';
import 'package:osama_consul/features/general/Registraion/domain/usecases/reset_password.dart';
import 'package:osama_consul/features/user/Edit%20Profile/data/datasources/remote_edit_ds_impl.dart';
import 'package:osama_consul/features/user/Edit%20Profile/data/repositories/edit_repo_impl.dart';
import 'package:osama_consul/features/user/Edit%20Profile/domain/usecases/edit_usecase.dart';
import 'package:osama_consul/features/user/Edit%20Profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:osama_consul/features/user/HomeLayout/data/datasources/home_ds_remote_impl.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';
import 'package:osama_consul/features/user/MyRequests/data/datasources/my_requests_ds_remote_impl.dart';
import 'package:osama_consul/features/user/MyRequests/data/repositories/my_requests_repo_impl.dart';
import 'package:osama_consul/features/user/MyRequests/domain/usecases/get_all_requests.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

import '../../features/general/Registraion/data/datasources/auth_remote_ds_impl.dart';
import '../../features/general/Registraion/data/repositories/auth_repo_impl.dart';
import '../../features/general/Registraion/domain/usecases/sign_in_usecase.dart';
import '../../features/general/Registraion/domain/usecases/sign_up_usecase.dart';
import '../../features/general/Registraion/presentation/bloc/registraion_bloc.dart';
import '../../features/user/HomeLayout/data/repositories/home_user_repo_impl.dart';
import '../../features/user/HomeLayout/domain/usecases/get_all_quotes_usecase.dart';
import '../api/api_manager.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Core
  sl.registerLazySingleton<ApiManager>(() => ApiManager());

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDSImpl>(
      () => AuthRemoteDSImpl(sl<ApiManager>()));

  // Auth Repository
  sl.registerLazySingleton<AuthRepoImpl>(
      () => AuthRepoImpl(sl<AuthRemoteDSImpl>()));

  // Auth Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepoImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepoImpl>()));
  // sl.registerLazySingleton(() => SignInGoogleUseCase(sl<AuthRepoImpl>()));
  // sl.registerLazySingleton(() => SignUpGoogleUsercase(sl<AuthRepoImpl>()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl<AuthRepoImpl>()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl<AuthRepoImpl>()));
  // Auth Bloc
  sl.registerFactory(() => RegistraionBloc(
      sl<SignInUseCase>(),
      sl<SignUpUseCase>(),
      sl<ForgetPasswordUseCase>(),
      sl<ResetPasswordUsecase>()));
  //HomeLayout data source
  sl.registerLazySingleton<HomeDsRemoteImpl>(
      () => HomeDsRemoteImpl(sl<ApiManager>()));
  //HomeLayout Repository
  sl.registerLazySingleton<HomeUserRepoImpl>(
      () => HomeUserRepoImpl(sl<HomeDsRemoteImpl>()));
  //HomeLayout usecase
  sl.registerLazySingleton(() => GetAllQuotesUseCase(sl<HomeUserRepoImpl>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<HomeUserRepoImpl>()));

  // HomeLayout Bloc
  sl.registerFactory(() => HomelayoutBloc(sl<LogoutUseCase>(),sl<GetAllQuotesUseCase>()));
  //MyRequest data source
  sl.registerLazySingleton<MyRequestsDsRemoteImpl>(
      () => MyRequestsDsRemoteImpl(sl<ApiManager>()));
  //MyRequest repo

  sl.registerLazySingleton<MyRequestsRepoImpl>(
      () => MyRequestsRepoImpl(sl<MyRequestsDsRemoteImpl>()));
  //MyRequest usecases

  sl.registerLazySingleton<GetAllRequestsUseCase>(
      () => GetAllRequestsUseCase(sl<MyRequestsRepoImpl>()));
  //MyRequest cubit

  sl.registerFactory(() => MyrequestsCubit(sl<GetAllRequestsUseCase>()));

  //homelayoutadmin bloc
  sl.registerFactory(() => HomeLayoutAdminBloc(sl<LogoutUseCase>()));
  //edit datasource
  sl.registerLazySingleton<RemoteEditDsImpl>(
      () => RemoteEditDsImpl(sl<ApiManager>()));
  //edit repo
  sl.registerLazySingleton<EditRepoImpl>(
      () => EditRepoImpl(sl<RemoteEditDsImpl>()));
  //edit usecases
  sl.registerLazySingleton<EditUsecase>(() => EditUsecase(sl<EditRepoImpl>()));
  //edit bloc
  sl.registerFactory(() => EditProfileBloc(sl<EditUsecase>()));
}
