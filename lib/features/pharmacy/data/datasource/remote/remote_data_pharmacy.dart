import 'dart:convert';
import 'package:pharma_plus/config/error/exceptions.dart';
import 'package:pharma_plus/config/error/failure.dart';
import 'package:pharma_plus/core/constants/constants.dart';
import 'package:pharma_plus/features/pharmacy/data/models/pharmacy.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class RemoteDataPharmacy {
  Future<List<PharmacyModel>> getPharmacies();
}

class RemoteDataPharmacyImpl implements RemoteDataPharmacy {
  final http.Client client;
  RemoteDataPharmacyImpl({required this.client});

  @override
  Future<List<PharmacyModel>> getPharmacies() async {
    try {
      final response = await client.get(
        Uri.parse('$APIBASEURL'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final dynamic data = jsonResponse['data'];
        if (data is List<dynamic>) {
          final pharmacies = data
              .map((json) =>
              PharmacyModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return pharmacies;
        } else {
          throw ServerFailure('Structure inattendue dans la réponse');
        }
      }else {
        throw ServerFailure('Erreur du serveur : ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkFailure('Erreur de réseau : ${e.toString()}');
    }
  }
}
