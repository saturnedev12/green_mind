abstract class AppState {}

class InitialState extends AppState {}

class ProgressState<T> extends AppState {
  T data;
  ProgressState({required this.data});
}

class PendingState<T> extends AppState {}

class FinishState<T> extends AppState {
  T data;
  FinishState({required this.data});
}

//state of request ended T is ServiceState
class DoneState<T> extends AppState {
  FinishState finishData;
  DoneState({required this.finishData});

  // FinishState getResult<U>({required U data}) => FinishState<U>(data: data);
}
