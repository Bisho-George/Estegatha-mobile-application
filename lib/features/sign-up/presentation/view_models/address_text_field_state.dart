part of 'address_text_field_cubit.dart';

@immutable
sealed class AddressTextFieldState {}

final class AddressTextFieldInitial extends AddressTextFieldState {}

final class AddressPredictionsLoadingState extends AddressTextFieldState {}

final class AddressPredictionsLoadedState extends AddressTextFieldState {
  final List<PlaceModel> predictions;

  AddressPredictionsLoadedState(this.predictions);
}

final class AddressPredictionsErrorState extends AddressTextFieldState {
  final String message;

  AddressPredictionsErrorState(this.message);
}
