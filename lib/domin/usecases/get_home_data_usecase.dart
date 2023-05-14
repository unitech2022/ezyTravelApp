import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/repostiory/base_repository.dart';

import '../../core/failur/failure.dart';
import '../entities/home.dart';

class GetHomeDataUseCase {
  final BaseRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure,Home>> execute()async{

    return await repository.getHomeData();
  }
}