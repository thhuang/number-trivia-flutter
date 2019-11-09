import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/storages/local_storage.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final LocalStorage localStorage;

  NumberTriviaLocalDataSourceImpl({@required this.localStorage});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    await localStorage.setString(CACHED_NUMBER_TRIVIA, jsonEncode(triviaToCache));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = await localStorage.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return NumberTriviaModel.fromJson(jsonDecode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
