part of 'create_field_bloc.dart';

abstract class CreateFieldEvent extends Equatable {
  const CreateFieldEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends CreateFieldEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppStarted';
}

class CreateNewField extends CreateFieldEvent {
    final String name;
    final String year;
    final String sowingDate;
    final List<List<double>> coordinates;
    final String cropType;

    const CreateNewField({
      required this.name,
      required this.year,
      required this.sowingDate,
      required this.coordinates,
      required this.cropType,
    });

    @override
    List<Object> get props => [name, year, sowingDate];

   
}