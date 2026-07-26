import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failures,SuccessType>> call(Params params);
}