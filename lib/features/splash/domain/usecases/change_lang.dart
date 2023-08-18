import 'package:dartz/dartz.dart';
import 'package:qutes_app/Core/error/failures.dart';
import 'package:qutes_app/Core/usaecase/usecase.dart';
import 'package:qutes_app/features/splash/domain/repositories/lang_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call([String? langCode]) async {
    return await langRepository.changeLang(langCode: langCode!);
  }
}
