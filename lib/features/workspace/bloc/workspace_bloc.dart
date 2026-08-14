import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  WorkspaceBloc() : super(WorkspaceInitial()) {
    on<WorkspaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
