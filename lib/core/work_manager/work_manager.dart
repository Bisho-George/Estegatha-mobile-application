import 'package:dio/dio.dart';
import 'package:estegatha/constants.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/core/firebase/notification.dart';
import 'package:estegatha/features/safty/data/api/fitness_connect_api.dart';
import 'package:estegatha/features/safty/data/api/send_fitness_api.dart';
import 'package:estegatha/features/safty/domain/repositories/fitness_connect_repo.dart';
import 'package:estegatha/features/sos/data/api/cancel_sos_api.dart';
import 'package:estegatha/features/sos/data/api/sos_api.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:workmanager/workmanager.dart';

import '../../features/safty/domain/model/health_metrices_model.dart';

@pragma('vm:entry-point')
callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "fitness_work":
        FitnessConnectRepository repository = FitnessConnectApi();
        SendFitnessDataApi sendFitnessDataApi = SendFitnessDataApi();
        var count = 15;
        while(count > 0){
          var data = await repository.fetchData();
          await sendFitnessDataApi.sendFitnessData(data);
          if(!isFineHealth(data)){
            NotificationService().showNotification('track health', 'track your health');
            SosApi().sendSos(type: 'INIT_HEALTH_ISSUE');
            CancelSosApi().sendFeedback('medical');
          }
          await Future.delayed(const Duration(minutes: 1), () => count--);
        }
        break;
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
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}

void initWorkManager(){
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
}
