import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pharma_plus/models/pharmacy/pharmacy.dart';


class PharmacyService {
  
  String baseUrl = 'http://192.168.1.67:8000/api/v1/pharmacies/index';

  Future<List<Pharmacy>> getAllPharmacies() async {
    try{

        var response = await http.get(Uri.parse(baseUrl));
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var items = data['data'];
          List<Pharmacy> pharmacies = [];
          for (var item in items) {
            pharmacies.add(Pharmacy.fromJson(item));
          }
          print("La liste des pharmacies: $pharmacies");
          return pharmacies;
        } else {
          return [];
        }

    }
    catch(e){
      throw Exception(e.toString());
    }

  }
}