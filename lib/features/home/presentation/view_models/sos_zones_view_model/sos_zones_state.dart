part of 'sos_zones_cubit.dart';

@immutable
sealed class SosZonesState {}

final class SosZonesInitial extends SosZonesState {}

final class SosZonesLoading extends SosZonesState {}

final class SosZonesSuccess extends SosZonesState {
  final List<SosZoneEntity> sosZones;

  SosZonesSuccess(this.sosZones);
}

final class SosZonesFailure extends SosZonesState {
  final String message;

  SosZonesFailure(this.message);
}
