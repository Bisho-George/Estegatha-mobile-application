// /*
// import 'package:flutter/services.dart';
// import 'package:health/health.dart';
//
// import '../../domain/repositories/fitness_connect_repo.dart';
//
// class FitnessConnectApi extends FitnessConnectRepository {
//   final health = HealthFactory();
//   @override
//   Future<List<BloodGlucose>> connect() async{
//     bool requested =
//     await health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);
//
//     if (requested) {
//       List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
//           DateTime.now().subtract(const Duration(days: 7)),
//           DateTime.now(),
//           [HealthDataType.BLOOD_GLUCOSE]);
//
//       return healthData.map((b) {
//         // print(b.value.toJson()['numericValue']);
//         return BloodGlucose(
//           // double.parse(b.value.toJson()['numericValue']),
//           5,
//           b.unitString,
//           b.dateFrom,
//           b.dateTo,
//         );
//       }).toList();
//     }
//     return [];
//   }
// }
// class BloodGlucose {
//   final double value;
//   final String unit;
//   final DateTime dateFrom;
//   final DateTime dateTo;
//
//   BloodGlucose(this.value, this.unit, this.dateFrom, this.dateTo);
// }
// */
