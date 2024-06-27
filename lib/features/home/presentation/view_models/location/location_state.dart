import 'package:geolocator/geolocator.dart';

class UserLocationState {
  final Position? position;
  final bool isAppBarVisible;

  UserLocationState({required this.position, this.isAppBarVisible = false});

  UserLocationState copyWith({Position? position, bool? isAppBarVisible, bool? isMarkerScaled}) {
    return UserLocationState(
      position: position ?? this.position,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
    );
  }
}
