import 'package:equatable/equatable.dart';

class PharmacyEntity extends Equatable {
  int? id;
  String? title;
  String? phone;
  String? location;
  String? comune;
  String? region;
  double? lattitude;
  double? longitude;
  String? opened_at;
  String? closed_at;

  PharmacyEntity({
    this.id,
    this.title,
    this.phone,
    this.location,
    this.comune,
    this.region,
    this.lattitude,
    this.longitude,
    this.opened_at,
    this.closed_at,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    phone,
    location,
    comune,
    region,
    lattitude,
    longitude,
    opened_at,
    closed_at,
  ];
}
