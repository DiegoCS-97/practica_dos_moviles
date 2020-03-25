part of 'apuntes_bloc.dart';

abstract class ApuntesState extends Equatable {
  const ApuntesState();

  File get image => null;
}

class ApuntesInitial extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends ApuntesState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends ApuntesState {
  //final String url;
  //CloudStoreSaved({@required this.url});
  @override
  List<Object> get props => [];//url];
}

class CloudStoreGetData extends ApuntesState {
  @override
  List<Object> get props => [];
}

class ChoosenImage extends ApuntesState {
  final File image;
  ChoosenImage({@required this.image});

  @override
  List<Object> get props => [image];
}