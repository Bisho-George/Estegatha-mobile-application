import 'package:flutter_bloc/flutter_bloc.dart';

class TrackCubit extends Cubit<bool> {
  TrackCubit() : super(false);

  String _trackedMemberName = '';

  void toggleLocationTracking() {
    emit(!state);
  }

  void setNameOfTheTrackedMember(String name) {
    _trackedMemberName = name;
  }

  String getTrackedMemberName() {
    return _trackedMemberName;
  }

  bool isTracking() {
    return state;
  }
}
