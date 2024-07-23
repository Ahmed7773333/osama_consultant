import 'package:get_it/get_it.dart';
import 'package:osama_consul/features/general/Registraion/domain/usecases/sign_in_google_usercase.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/datasources/remote_slots_ds_impl.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/repositories/slots_repo_impl.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_all_schedule.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_schedule_by_id.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/presentation/bloc/meetings_control_bloc.dart';
import 'package:osama_consul/features/user/HomeLayout/presentation/bloc/homelayout_bloc.dart';

import '../../features/admin/Meetings Control/domain/usecases/get_slot_by_id.dart';
import '../../features/general/Registraion/data/datasources/auth_remote_ds_impl.dart';
import '../../features/general/Registraion/data/repositories/auth_repo_impl.dart';
import '../../features/general/Registraion/domain/usecases/sign_in_usecase.dart';
import '../../features/general/Registraion/domain/usecases/sign_up_usecase.dart';
import '../../features/general/Registraion/presentation/bloc/registraion_bloc.dart';
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
  sl.registerLazySingleton(() => GetSlotById(sl<SlotsRepoImpl>()));

  // meetings controll Bloc
  sl.registerFactory(() => MeetingsControlBloc(sl<AddSlotUseCase>(),
      sl<GetAllSchedules>(), sl<GetScheduleById>(), sl<GetSlotById>()));
  //HomeLayout usecase
  sl.registerLazySingleton(() => ConfirmBookingUseCase());
  // HomeLayout Bloc
  sl.registerFactory(() => HomelayoutBloc(sl<ConfirmBookingUseCase>(),
      sl<GetAllSchedules>(), sl<GetScheduleById>(), sl<GetSlotById>()));
}
