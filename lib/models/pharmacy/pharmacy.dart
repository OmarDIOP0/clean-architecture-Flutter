class Pharmacy {
  int? id;
  String? title;
  String? address;
  String? phone;
  String? location;
  String? comune;
  String? region;
  double lattitude;
  double longitude;
  String? opened_at;
  String? closed_at;

  Pharmacy({
    this.id,
    this.title,
    this.address,
    this.phone,
    this.location,
    this.comune,
    this.region,
    required this.lattitude,
    required this.longitude,
    this.opened_at,
    this.closed_at,
  });
  factory
   Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      phone: json['phone'],
      location: json['location'],
      comune: json['comune'],
      region: json['region'],
      lattitude: json['lattitude'],
      longitude: json['longitude'],
      opened_at: json['opened_at'],
      closed_at: json['closed_at'],
    );
    }
}