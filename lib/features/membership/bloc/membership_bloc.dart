import 'package:dev_hub/features/membership/domain/usecases/search_users_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:equatable/equatable.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final SearchUsersUseCase _searchUsersUseCase;

  MembershipBloc({required this._searchUsersUseCase})
    : super(MembershipInitial()) {
    on<SearchUserEvent>((event, emit) async {
      emit(SearchingUsersState());
      final result = await _searchUsersUseCase.call(event.searchQuery);
      result.fold(
        (error) => emit(SearchFailureState(error.message)),
        (usersList) => usersList.isNotEmpty
            ? emit(UsersFoundState(usersList))
            : emit(NoUsersFoundState()),
      );
    });
  }
}
