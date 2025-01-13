import 'package:pharma_plus/features/pharmacy/domain/entities/pharmacy.dart';

class PharmacyModel extends PharmacyEntity {
  PharmacyModel({
    int? id,
    String? title,
    String? phone,
    String? location,
    String? comune,
    String? region,
    double? lattitude,
    double? longitude,
    String? opened_at,
    String? closed_at,
  }):super(
    id: id,
    title: title,
    phone:phone,
    location:location,
    comune:comune,
    region:region,
    lattitude:lattitude,
    longitude:longitude,
    opened_at:opened_at,
    closed_at:closed_at,
  );
  
    factory PharmacyModel.fromJson(Map<String, dynamic> json) {
      print('Création du modèle: $json'); 
    return PharmacyModel(
       id: json['id'],
       title: json['title'],
       phone: json['phone'],
       location:json['location'],
       region: json['region'],
       comune: json['comune'],
       lattitude: json['lattitude'],
       longitude: json['longitude'],
       opened_at: json['opened_at'],
       closed_at: json['closed_at']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phone': phone,
      'location':location,
      'region':region,
      'comune':comune,
      'lattitude':lattitude,
      'longitude':longitude,
      'opened_at':opened_at,
      'closed_at':closed_at
    };
  }
}

