import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {

    }
    return Future.value(true);
  });
}

class SchedualWork{
  void schedualFitnessWork(){
    Workmanager().registerPeriodicTask(
      "1",
      "fitness_work",
      frequency: const Duration(minutes: 15),
    );
  }
}

void _initWorkManager(){
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
}
