
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

class GetTypesDocumentUseCase {

  UtilsRepository repository;

  GetTypesDocumentUseCase({
    required this.repository
  });

  Future<ResultType<List<TypeDocumentEntity>, ErrorEntity>> execute(){
    return repository.getTypesDocument();
  }

}