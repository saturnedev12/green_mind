import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenmind/data/models/field_model/field_model.dart';
import 'package:greenmind/data/repository/field/field_repository.dart';

part 'create_field_event.dart';
part 'create_field_state.dart';

class CreateFieldBloc extends Bloc<CreateFieldEvent, CreateFieldState> {
  FieldRepository? fieldRepository;
  CreateFieldBloc({required  this.fieldRepository}) : super(CreateFieldInitial()) {
              on<CreateNewField>(onCreateNewField);

  }

  void onCreateNewField(
       CreateNewField event, Emitter<CreateFieldState> emit
       ) async {
          print("test");
        emit(CreateFieldLoading()) ;
      final FieldCreated request = await fieldRepository!.createdNewField(event.name, event.year, event.sowingDate, event.cropType, event.coordinates);
       print("c'est bon");
       emit(CreateFieldCreated()) ;
}
}