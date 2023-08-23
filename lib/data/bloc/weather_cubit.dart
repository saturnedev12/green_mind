import 'package:bloc/bloc.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';
import 'package:greenmind/data/repository/weather/weather_repository.dart';

class WeatherCubit extends Cubit<RequestState> {
  WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository}) : super(InitialState());
  void fetchWeatherData() async {
    emit(LoadingState());

    try {
      List<WeatherDataAgregationModel> weatherDataList =
          await weatherRepository.getWeatherBetween();
      emit(LoadeState(data: weatherDataList));
    } catch (error) {
      emit(ErrorState(
          errorMessage:
              'Erreur lors du chargement des données météorologiques'));
    }
  }
}

abstract class RequestState {}

class InitialState extends RequestState {}

class LoadeState extends RequestState {
  List<WeatherDataAgregationModel> data;
  LoadeState({required this.data});
}

class LoadingState extends RequestState {}

class ErrorState extends RequestState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}
