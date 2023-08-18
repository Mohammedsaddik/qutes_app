import 'dart:convert';
import 'package:qutes_app/Core/error/exceptions.dart';
import 'package:qutes_app/features/random_quote/data/models/quote_model.dart';
import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSourse {
  Future<Quote> getLastQuote();
  Future<void> cashQuote(QuoteModel quoteModel);
}

class LocalDataSourseImp implements LocalDataSourse {
  final SharedPreferences sharedPreferences;
  LocalDataSourseImp({required this.sharedPreferences});
  @override
  Future<void> cashQuote(QuoteModel quoteModel) {
    return sharedPreferences.setString(
        'Cache Failure', json.encode(quoteModel));
  }

  @override
  Future<Quote> getLastQuote() {
    final jsonString = sharedPreferences.getString('Cache Failure');
    if (jsonString != null) {
      final cacheRandomQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }
}
