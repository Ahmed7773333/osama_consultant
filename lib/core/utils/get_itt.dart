import 'package:get_it/get_it.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/admin/Requests%20Page/data/datasources/requests_admin_ds_remote_impl.dart';
import 'package:osama_consul/features/admin/Requests%20Page/data/repositories/requests_admin_repo_impl.dart';
import 'package:osama_consul/features/admin/Requests%20Page/presentation/bloc/requests_page_bloc.dart';
import 'package:osama_consul/features/general/Registraion/domain/usecases/sign_in_google_usercase.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/datasources/remote_slots_ds_impl.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/repositories/slots_repo_impl.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_all_schedule.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_schedule_by_id.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/bloc/meetings_control_bloc.dart';
import 'package:osama_consul/features/user/HomeLayout/data/datasources/home_ds_remote_impl.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';
import 'package:osama_consul/features/user/MyRequests/data/datasources/my_requests_ds_remote_impl.dart';
import 'package:osama_consul/features/user/MyRequests/data/repositories/my_requests_repo_impl.dart';
import 'package:osama_consul/features/user/MyRequests/domain/usecases/get_all_requests.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

import '../../features/admin/Requests Page/domain/usecases/get_all_requests.dart';
import '../../features/general/Registraion/data/datasources/auth_remote_ds_impl.dart';
import '../../features/general/Registraion/data/repositories/auth_repo_impl.dart';
import '../../features/general/Registraion/domain/usecases/sign_in_usecase.dart';
import '../../features/general/Registraion/domain/usecases/sign_up_usecase.dart';
import '../../features/general/Registraion/presentation/bloc/registraion_bloc.dart';
import '../../features/user/HomeLayout/data/repositories/home_user_repo_impl.dart';
import '../../features/user/HomeLayout/domain/usecases/confirem_booking.dart';
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
  sl.registerLazySingleton(() => SignInGoogleUseCase(sl<AuthRepoImpl>()));
  // Auth Bloc
  sl.registerFactory(() => RegistraionBloc(
      sl<SignInUseCase>(), sl<SignUpUseCase>(), sl<SignInGoogleUseCase>()));
  // meetings controll Data source
  sl.registerLazySingleton<RemoteSlotsDsImpl>(
      () => RemoteSlotsDsImpl(sl<ApiManager>()));
  // meetings controll Repository
  sl.registerLazySingleton<SlotsRepoImpl>(
      () => SlotsRepoImpl(sl<RemoteSlotsDsImpl>()));
  // meetings controll Use Cases
  sl.registerLazySingleton(() => AddSlotUseCase(sl<SlotsRepoImpl>()));
  sl.registerLazySingleton(() => GetAllSchedules(sl<SlotsRepoImpl>()));
  sl.registerLazySingleton(() => GetScheduleById(sl<SlotsRepoImpl>()));

  // meetings controll Bloc
  sl.registerFactory(() => MeetingsControlBloc(
      sl<AddSlotUseCase>(), sl<GetAllSchedules>(), sl<GetScheduleById>()));
  //HomeLayout data source
  sl.registerLazySingleton<HomeDsRemoteImpl>(
      () => HomeDsRemoteImpl(sl<ApiManager>()));
  //HomeLayout Repository
  sl.registerLazySingleton<HomeUserRepoImpl>(
      () => HomeUserRepoImpl(sl<HomeDsRemoteImpl>()));
  //HomeLayout usecase
  sl.registerLazySingleton(() => ConfirmBookingUseCase(sl<HomeUserRepoImpl>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<HomeUserRepoImpl>()));

  // HomeLayout Bloc
  sl.registerFactory(() => HomelayoutBloc(sl<ConfirmBookingUseCase>(),
      sl<GetAllSchedules>(), sl<GetScheduleById>(), sl<LogoutUseCase>()));
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
  //Requests admin data source
  sl.registerLazySingleton<RequestsAdminDsRemoteImpl>(
      () => RequestsAdminDsRemoteImpl(sl<ApiManager>()));
  //Requests admin repo
  sl.registerLazySingleton<RequestsAdminRepoImpl>(
      () => RequestsAdminRepoImpl(sl<RequestsAdminDsRemoteImpl>()));
  //Requests admin usecases
  sl.registerLazySingleton<GetAllRequestsAdminUseCase>(
      () => GetAllRequestsAdminUseCase(sl<RequestsAdminRepoImpl>()));
  //Requests bloc
  sl.registerFactory(() => RequestsPageBloc(sl<GetAllRequestsAdminUseCase>()));
  //homelayoutadmin bloc
  sl.registerFactory(() => HomeLayoutAdminBloc(sl<LogoutUseCase>()));
}
