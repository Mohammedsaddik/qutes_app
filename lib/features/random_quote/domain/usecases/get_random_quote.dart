import 'package:dartz/dartz.dart';
import 'package:qutes_app/Core/error/failures.dart';
import 'package:qutes_app/Core/usaecase/usecase.dart';
import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';
import 'package:qutes_app/features/random_quote/domain/repositories/quote_repositery.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call([NoParams? params]) {
    return quoteRepository.getRandomQuote();
  }
}
