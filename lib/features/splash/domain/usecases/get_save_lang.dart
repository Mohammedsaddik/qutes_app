import 'package:dartz/dartz.dart';
import 'package:qutes_app/Core/error/failures.dart';
import 'package:qutes_app/Core/usaecase/usecase.dart';
import 'package:qutes_app/features/splash/domain/repositories/lang_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call([NoParams? params]) async {
    return await langRepository.getSavedLang();
  }
}
