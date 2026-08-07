// import 'package:dev_hub/core/errors/failures.dart';
// import 'package:fpdart/fpdart.dart';
//
// import '../../../../../../core/usecases/usecase.dart';
// import '../../entities/user_entity.dart';
// import '../../repository/auth_repository.dart';

// class CurrentUser implements UseCase<UserEntity?, NoParams> {
//   final AuthRepository repo;
//   CurrentUser(this.repo);
//
//   @override
//   Future<Either<Failure, UserEntity?>> call(NoParams params) async{
//     try{
//       return await repo.currentUser();
//     }catch(e){
//       return left(Failure(e.toString()));
//     }
//   }
// }
