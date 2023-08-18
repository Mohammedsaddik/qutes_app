import 'package:qutes_app/Core/api/api_consumer.dart';
import 'package:qutes_app/Core/api/end_point.dart';
import 'package:qutes_app/features/random_quote/data/models/quote_model.dart';

abstract class RemoteDataSourse {
  Future<QuoteModel> getRandomQuote();
}

class RemoteDataSourseImp implements RemoteDataSourse {
  ApiConsumer apiConsumer;
  RemoteDataSourseImp({required this.apiConsumer});
  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuote);
    return QuoteModel.fromJson(response);
  }
}
