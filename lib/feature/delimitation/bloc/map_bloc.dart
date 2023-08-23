import 'package:flutter_bloc/flutter_bloc.dart';

// États possibles

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapBrowseState()) {
    on<SendPositionEvent>(_onSendPosition);
  }

  void _onSendPosition(SendPositionEvent event, Emitter<MapState> emit) {
    emit(MapBrowseState());
    //_tickerSubscription?.cancel();
  }
}

abstract class MapState {}

class MapBrowseState extends MapState {}

class MapMapState extends MapState {}

abstract class MapEvent {}

class SendPositionEvent extends MapEvent {
  // MapState? state = MapBrowseState();
  // SendPositionEvent({this.state});
}
