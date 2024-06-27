import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'location_state.dart';
class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationState(position: null)) {
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    print('Position: $position');
    emit(UserLocationState(position: position));
  }

  void showToggleBar() {
    emit(state.copyWith(isAppBarVisible: true));
  }

  void hideToggleBar() {
    emit(state.copyWith(isAppBarVisible: false));
  }
}
