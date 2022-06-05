abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonErrorState extends CommonState {
  final String message;
  CommonErrorState({
    required this.message,
  });
}

class CommonSucessState<T> extends CommonState {
  T data;
  CommonSucessState({
    required this.data,
  });
}
class CommonFetchedState<T> extends CommonState {
  List<T> items;
  CommonFetchedState({
    required this.items,
  });
}
