import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qutes_app/Core/error/failures.dart';
import 'package:qutes_app/Core/usaecase/usecase.dart';
import 'package:qutes_app/Core/utils/app_string.dart';
import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';
import '../../domain/usecases/get_random_quote.dart';
part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUserCase;
  RandomQuoteCubit({required this.getRandomQuoteUserCase})
      : super(RandomQuoteInitial());
  Future<void> getRandomQuote() async {
    emit(RandomQuoteLoading());
    Either<Failure, Quote> responce = await getRandomQuoteUserCase(NoParams());
    emit(responce.fold(
        (failer) => RandomQuoteError(errorMsg: _mapFailureToMsg(failer)),
        (quote) => RandomQuoteSuccess(quote: quote)));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
