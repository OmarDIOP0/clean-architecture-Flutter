// Localisation Event
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserLocationEvent extends LocationEvent {}

// Localisation State
abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}
class LocationLoading extends LocationState {}
class LocationLoaded extends LocationState {
  final LatLng userLocation;

  LocationLoaded(this.userLocation);

  @override
  List<Object?> get props => [userLocation];
}

class LocationError extends LocationState {
  final String errorMessage;

  LocationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Localisation Bloc
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator geolocator;

  LocationBloc({required this.geolocator}) : super(LocationInitial()) {
    on<GetUserLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        if (!await Geolocator.isLocationServiceEnabled()) {
          throw 'Location services are disabled';
        }
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw 'Location permission denied';
          }
        }
        if (permission == LocationPermission.deniedForever) {
          throw 'Location permission permanently denied';
        }
        final position = await Geolocator.getCurrentPosition();
        emit(LocationLoaded(LatLng(position.latitude, position.longitude)));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });
  }
}
