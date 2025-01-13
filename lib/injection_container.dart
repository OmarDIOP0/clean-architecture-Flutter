import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_plus/core/network/network_info.dart';
import 'package:pharma_plus/features/pharmacy/data/datasource/remote/remote_data_pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/data/repository/pharmacy_repository_impl.dart';
import 'package:pharma_plus/features/pharmacy/domain/repository/pharmacy_repository.dart';
import 'package:pharma_plus/features/pharmacy/domain/usecases/get_pharmacies.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/localisation_bloc.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/pharmacy_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => PharmacyBloc(getPharmacies: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPharmacies(sl()));

  // Repository
  sl.registerLazySingleton<PharmacyRepository>(
    () => PharmacyRepositoryImpl(
      remoteDataPharmacy: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataPharmacy>(
    () => RemoteDataPharmacyImpl(client: sl()),
  );

   // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

    // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Register Geolocator
  sl.registerLazySingleton<Geolocator>(() => Geolocator());

  // Register LocationBloc
  sl.registerFactory(() => LocationBloc(geolocator: sl()));
}
