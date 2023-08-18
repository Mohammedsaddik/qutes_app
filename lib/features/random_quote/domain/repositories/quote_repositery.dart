import 'package:dartz/dartz.dart';
import '../../../../Core/error/failures.dart';
import '../entities/quotes.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}