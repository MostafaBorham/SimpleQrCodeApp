part of 'scan_cubit.dart';

abstract class ScanState extends Equatable {
  const ScanState();
}

class ScanInitial extends ScanState {
  @override
  List<Object> get props => [];
}

///Get Scans States
class GetScansLoadingState extends ScanState {
  @override
  List<Object?> get props => [];
}

class GetScansSuccessState extends ScanState {
  final List<ScanInfo>? scans;
  const GetScansSuccessState({this.scans});
  @override
  List<Object?> get props => [scans];
}

class GetScansFailedState extends ScanState {
  final String? message;
  const GetScansFailedState({this.message});
  @override
  List<Object?> get props => [message];
}

///Scan States
class ScanLoadingState extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanSuccessState extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanFailedState extends ScanState {
  final String? message;
  const ScanFailedState({this.message});
  @override
  List<Object?> get props => [message];
}
