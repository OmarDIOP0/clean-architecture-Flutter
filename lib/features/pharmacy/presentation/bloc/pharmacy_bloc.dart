import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_plus/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:pharma_plus/features/pharmacy/domain/usecases/get_pharmacies.dart';

abstract class PharmacyEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetPharmaciesEvent extends PharmacyEvent{}
//States

abstract class PharmacyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PharmacyInitial extends PharmacyState {}
class PharmacyLoading extends PharmacyState {}
class PharmacyLoaded extends PharmacyState {
  final List<PharmacyEntity> pharmacies;

  PharmacyLoaded(this.pharmacies);

  @override
  List<Object?> get props => [pharmacies];
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);

  @override
  List<Object?> get props => [message];
}

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  final GetPharmacies getPharmacies;

  PharmacyBloc({required this.getPharmacies}) : super(PharmacyInitial()) {
    on<GetPharmaciesEvent>((event, emit) async {
      emit(PharmacyLoading());
      final result = await getPharmacies.execute();
      result.fold(
        (failure) => emit(PharmacyError(failure.message)),
        (pharmacies) {
          emit(PharmacyLoaded(pharmacies));
        }
      );
    });
  }
}

