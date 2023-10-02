

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/add_product/presentation/blocs/add_product_bloc.dart';
import 'package:supermarket/features/launcher/repositories/bocs/launcher_bloc.dart';
import 'package:supermarket/features/main_page/presentations/blocs/main_bloc.dart';
import 'package:supermarket/features/products/presentations/blocs/edit_price/edit_price_bloc.dart';
import 'package:supermarket/features/products/presentations/blocs/products_bloc.dart';

final sl=GetIt.instance;

Future<void>init()async {

  /// Features

  /// Launcher //////////////////////////////////////////////////////////////////////
  // Bloc
  sl.registerFactory(() => LauncherBloc());
  // useCase
  // repository
  // dataSource

  /// add product //////////////////////////////////////
  // Bloc
  sl.registerFactory(() => AddProductBloc());
  // useCase
  // repository
  // dataSource


  /// products
  // Bloc
  sl.registerFactory(() => ProductsBloc());
  // useCase
  // repository
  // dataSource
  /// edit price

  // Bloc
  sl.registerFactory(() => EditPriceBloc());
  // useCase
  // repository
  // dataSource


/// Main
  // Bloc
  sl.registerFactory(() => MainBloc());
  // useCase
  // repository
  // dataSource


  // Bloc
  // useCase
  // repository
  // dataSource
  /// Core//////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///External//////////////////////////////////////////////////////////////////////
  final sharedPreferences =await SharedPreferences.getInstance();
  sl.registerLazySingleton(() =>sharedPreferences );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


}