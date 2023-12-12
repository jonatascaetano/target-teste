import 'package:equatable/equatable.dart';

class DataCaptureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataCaptureInitialState extends DataCaptureState {}

class DataCaptureLoadedState extends DataCaptureState {
  final List<String> capturedData;

  DataCaptureLoadedState(this.capturedData);

  @override
  List<Object?> get props => [capturedData];
}

class DataCaptureErrorState extends DataCaptureState {
  final String errorMessage;

  DataCaptureErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
