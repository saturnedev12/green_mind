part of 'create_field_bloc.dart';

abstract class CreateFieldState extends Equatable {
  const CreateFieldState();
  
  @override
  List<Object> get props => [];
}

class CreateFieldInitial extends CreateFieldState {}
class CreateFieldLoading extends CreateFieldState {}
class CreateFieldCreated extends CreateFieldState {}
class CreateFieldError extends CreateFieldState {
   final String error;

   CreateFieldError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
