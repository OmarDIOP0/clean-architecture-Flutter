import 'package:dartz/dartz.dart';
import 'package:pharma_plus/config/error/exceptions.dart';
import 'package:pharma_plus/config/error/failure.dart';
import 'package:pharma_plus/core/network/network_info.dart';
import 'package:pharma_plus/features/pharmacy/data/datasource/remote/remote_data_pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/data/models/pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/domain/repository/pharmacy_repository.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  final RemoteDataPharmacy remoteDataPharmacy;
  final NetworkInfo networkInfo;
  PharmacyRepositoryImpl({required this.remoteDataPharmacy, required this.networkInfo});

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacies() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePharmacies = await remoteDataPharmacy.getPharmacies();
        return Right(remotePharmacies);
      } on ServerException {
        return Left(ServerFailure('Erreur du serveur'));
      }
    } else {
      return Left(NetworkFailure('Pas de Connexion internet'));
    }
  }
}
