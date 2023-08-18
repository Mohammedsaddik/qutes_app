part of 'random_quote_cubit.dart';

abstract class RandomQuoteState extends Equatable {
  const RandomQuoteState();

  @override
  List<Object> get props => [];
}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteLoading extends RandomQuoteState {}

class RandomQuoteSuccess extends RandomQuoteState {
  final Quote quote;
  const RandomQuoteSuccess({required this.quote});
  @override
  List<Object> get props => [quote];
}

class RandomQuoteError extends RandomQuoteState {
  final String errorMsg;
  const RandomQuoteError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
