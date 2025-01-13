import 'package:dartz/dartz.dart';
import 'package:pharma_plus/config/error/failure.dart';
import 'package:pharma_plus/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/domain/repository/pharmacy_repository.dart';

class GetPharmacies {
  final PharmacyRepository pharmacyRepository;
  GetPharmacies(this.pharmacyRepository);

  Future<Either<Failure, List<PharmacyEntity>>> execute() async {
    return await pharmacyRepository.getPharmacies();
  }
}
