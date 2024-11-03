import 'package:equatable/equatable.dart';

// Location Events
abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLocation extends LocationEvent {}
