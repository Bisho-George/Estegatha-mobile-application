import 'package:estegatha/features/organization/presentation/view/main/organization_detail_page.dart';
import 'package:estegatha/features/safety/presentation/view/widgets/health_record_card.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/constant/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHealthRecordList extends StatefulWidget {
  String recordType;
  UserHealthRecordList({super.key, required this.recordType});

  @override
  _UserHealthRecordListState createState() => _UserHealthRecordListState();
}

class _UserHealthRecordListState extends State<UserHealthRecordList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserHealthCubit>(context, listen: false)
        .getUserHealthInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHealthCubit, UserHealthState>(
      builder: (context, state) {
        if (state is UserHealthInfoLoaded) {
          final illnesses = state.userHealthInfo.illnesses;
          final medicines = state.userHealthInfo.medicines;

          final selectedRecord =
              widget.recordType == ConstantVariables.diseaseType
                  ? illnesses
                  : widget.recordType == ConstantVariables.medicineType
                      ? medicines
                      : null;

          if (selectedRecord!.isEmpty) {
            return const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ConstantSizes.defaultSpace),
              child: Center(
                child: Text(
                  'No records found',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
          return Column(
            children: selectedRecord.map((record) {
              return HealthRecordCard(
                date: 'Monday, 27 March 2023', // TODO: Replace with actual date
                chronicDisease: record,

                onTapDeleteRecord: () {
                  if (selectedRecord == illnesses) {
                    BlocProvider.of<UserHealthCubit>(context, listen: false)
                        .deleteUserDisease(record);
                  } else if (selectedRecord == medicines) {
                    BlocProvider.of<UserHealthCubit>(context, listen: false)
                        .deleteUserMedicine(record);
                  }
                },
              );
            }).toList(),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: ConstantSizes.defaultSpace),
            child: Center(child: Loader()),
          );
        }
      },
    );
  }
}
