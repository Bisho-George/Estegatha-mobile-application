import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
log('onChange -- bloc: $bloc, change: ${change.toString()}');
    // TODO: implement onChange
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    log('onCreate -- bloc: ${bloc.state}');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
   log('onClose -- bloc: ${bloc.state}');
    super.onClose(bloc);
  }
}