import 'package:bloc/bloc.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:equatable/equatable.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  MembershipBloc() : super(MembershipInitial()) {
    on<MembershipEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
