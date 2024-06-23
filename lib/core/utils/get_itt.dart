// import 'package:get_it/get_it.dart';

// final GetIt sl = GetIt.instance;

// Future<void> init() async {
//   // Bloc
//   sl.registerFactory(
//       () => HomeLayoutBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

//   // Use Cases
//   sl.registerLazySingleton(() => GetWishListUseCase(sl()));
//   sl.registerLazySingleton(() => GetAllCategories(sl()));
//   sl.registerLazySingleton(() => GetAllProducts(sl()));
//   sl.registerLazySingleton(() => GetCartListUseCase(sl()));
//   sl.registerLazySingleton(() => AddCartUseCase(sl()));
//   sl.registerLazySingleton(() => DeleteCartUseCase(sl()));
//   sl.registerLazySingleton(() => AddWishListUseCase(sl()));
//   sl.registerLazySingleton(() => DeleteWishListUseCase(sl()));

//   // Repository
//   sl.registerLazySingleton(() => HomeRepoImpl(sl()));

//   // Data sources
//   sl.registerLazySingleton(() => HomeRemoteDsImple(sl()));

//   // Core
//   sl.registerLazySingleton(() => ApiManager());
// }
