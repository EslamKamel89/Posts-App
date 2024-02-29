import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/posts/data/datasource/post_local_data_source.dart';
import '../feature/posts/data/datasource/post_remote_data_source.dart';
import '../feature/posts/data/repositories/post_repository_imp.dart';
import '../feature/posts/domain/repositories/post_repository.dart';
import '../feature/posts/domain/usecases/add_post_usecase.dart';
import '../feature/posts/domain/usecases/delete_post_usecase.dart';
import '../feature/posts/domain/usecases/get_all_posts_usecase.dart';
import '../feature/posts/domain/usecases/update_post_usecase.dart';
import '../feature/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../feature/posts/presentation/bloc/post_bloc/post_bloc.dart';
import 'network/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! -- Features -- Posts ---------------------------------------------------------------------------------
  //? Bloc ....................................................................................
  sl.registerFactory<PostBloc>(() => PostBloc(getAllPostsUseCase: sl()));
  sl.registerFactory<AddDeleteUpdatePostBloc>(
    () => AddDeleteUpdatePostBloc(
      addPostUseCase: sl(),
      deletePostUseCase: sl(),
      updatePostUseCase: sl(),
    ),
  );
  //? UseCases ....................................................................................
  sl.registerLazySingleton<GetAllPostsUseCase>(() => GetAllPostsUseCase(repository: sl()));
  sl.registerLazySingleton<AddPostUseCase>(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase(repository: sl()));
  //? Repository ....................................................................................
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImp(
      remoteDataSource: sl(), //
      localDataSource: sl(), //
      networkInfo: sl(), //
    ),
  );
  //? DataSources ....................................................................................
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(client: sl())); //
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp(sharedPreferences: sl())); //

  //! -- core ---------------------------------------------------------------------------------
  //? NetworkInfo ....................................................................................
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(internetConnectionChecker: sl())); //

  //! -- External ---------------------------------------------------------------------------------
  //? Internet Connection Checker ....................................................................................
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker()); //
  //? http client ....................................................................................
  sl.registerLazySingleton<http.Client>(() => http.Client()); //
  //? sharedPreferences ....................................................................................
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences); //
}
