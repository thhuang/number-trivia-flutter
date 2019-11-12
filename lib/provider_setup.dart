import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/http_client.dart';
import 'core/network/network_info.dart';
import 'core/presentation/utils/input_converter.dart';
import 'core/storages/local_storage.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/logicholders/number_trivia_notifier.dart';

List<SingleChildCloneableWidget> providers = [
  ...externalServices,
  ...coreProviders,
  ...featureProviders,
];

List<SingleChildCloneableWidget> featureProviders = [
  ...dataSourceProviders,
  ...repositoryProviders,
  ...useCaseProviders,
  ...logicHolderProviders,
];

List<SingleChildCloneableWidget> logicHolderProviders = [
  ChangeNotifierProxyProvider3<GetConcreteNumberTrivia, GetRandomNumberTrivia,
      InputConverter, NumberTriviaNotifier>(
    builder: (_, concrete, random, inputConverter, __) => NumberTriviaNotifier(
      concrete: concrete,
      random: random,
      inputConverter: inputConverter,
    ),
  ),
];

List<SingleChildCloneableWidget> useCaseProviders = [
  ProxyProvider<NumberTriviaRepository, GetConcreteNumberTrivia>(
    builder: (_, repository, __) => GetConcreteNumberTrivia(
      repository: repository,
    ),
  ),
  ProxyProvider<NumberTriviaRepository, GetRandomNumberTrivia>(
    builder: (_, repository, __) => GetRandomNumberTrivia(
      repository: repository,
    ),
  ),
];

List<SingleChildCloneableWidget> repositoryProviders = [
  ProxyProvider3<NumberTriviaLocalDataSource, NumberTriviaRemoteDataSource,
      NetworkInfo, NumberTriviaRepository>(
    builder: (_, localDataSource, remoteDataSource, networkInfo, __) =>
        NumberTriviaRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    ),
  ),
];

List<SingleChildCloneableWidget> dataSourceProviders = [
  ProxyProvider<LocalStorage, NumberTriviaLocalDataSource>(
    builder: (_, localStorage, __) => NumberTriviaLocalDataSourceImpl(
      localStorage: localStorage,
    ),
  ),
  ProxyProvider<HttpClient, NumberTriviaRemoteDataSource>(
    builder: (_, client, __) => NumberTriviaRemoteDataSourceImpl(
      client: client,
    ),
  ),
];

List<SingleChildCloneableWidget> coreProviders = [
  Provider<InputConverter>.value(
    value: InputConverter(),
  ),
  ProxyProvider<DataConnectionChecker, NetworkInfo>(
    builder: (_, dataConnectionChecker, __) => NetworkInfoImpl(
      dataConnectionChecker: dataConnectionChecker,
    ),
  ),
  ProxyProvider<SharedPreferences, LocalStorage>(
    builder: (_, sharedPreferences, __) => LocalStorageImpl(
      sharedPreferences: sharedPreferences,
    ),
  ),
  ProxyProvider<http.Client, HttpClient>(
    builder: (_, client, __) => HttpClientImpl(
      client: client,
    ),
  ),
];

List<SingleChildCloneableWidget> externalServices = [
  Provider<DataConnectionChecker>.value(
    value: DataConnectionChecker(),
  ),
  FutureProvider<SharedPreferences>.value(
    value: SharedPreferences.getInstance(),
  ),
  Provider<http.Client>.value(
    value: http.Client(),
  ),
];
