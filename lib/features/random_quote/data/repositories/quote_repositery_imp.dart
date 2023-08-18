import 'package:dartz/dartz.dart';
import 'package:qutes_app/Core/error/exceptions.dart';
import 'package:qutes_app/Core/error/failures.dart';
import 'package:qutes_app/Core/network/network_info.dart';
import 'package:qutes_app/features/random_quote/data/datasources/local_data_sourse.dart';
import 'package:qutes_app/features/random_quote/data/datasources/remote_data_sourse.dart';
import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';
import 'package:qutes_app/features/random_quote/domain/repositories/quote_repositery.dart';

class QuoteRepositeryImp implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSourse remoteDataSourse;
  final LocalDataSourse localDataSourse;

  QuoteRepositeryImp(
      {required this.networkInfo,
      required this.remoteDataSourse,
      required this.localDataSourse});
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomQuote = await remoteDataSourse.getRandomQuote();
        localDataSourse.cashQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cashRandomQuote = await localDataSourse.getLastQuote();
        return Right(cashRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
