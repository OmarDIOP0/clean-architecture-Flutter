import 'package:dartz/dartz.dart';
import 'package:pharma_plus/config/error/failure.dart';
import 'package:pharma_plus/features/pharmacy/domain/entities/pharmacy.dart';

abstract class PharmacyRepository{
  Future<Either<Failure, List<PharmacyEntity>>> getPharmacies();
}