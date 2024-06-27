import 'package:estegatha/features/organization/domain/models/organization.dart';
import 'package:estegatha/features/sos/data/api/organizations_api.dart';
import 'package:estegatha/features/sos/presentation/pages/cancel_sos.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/send_sos_status.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common/styles/text_styles.dart';
import '../../../organization/domain/models/member.dart';
import '../../../organization/domain/models/organizationMember.dart';
import '../widgets/member_bubble_widget.dart';
import '../widgets/send_member_received_widget.dart';
import '../widgets/sos_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SendSos extends StatelessWidget {
  static String routeName = '/sos/send-sos';
  const SendSos({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'SOS'),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: responsiveHeight(160),
            ),
            SosButtonWidget(
              onTap: () {
                BlocProvider.of<SendSosCubit>(context).sendSos();
              },
            ),
            SizedBox(
              height: responsiveHeight(200),
            ),
            BlocConsumer<SendSosCubit, SendSosStatus>(
              builder: (context, state) {
                if(state is SendSosLoading){
                  return const CircularProgressIndicator();
                }
                else if(state is MembersReceivedStatus){
                  List<OrganizationMember> members = state.members;
                  return SosReceivedMembersWidget(members: members);
                }
                return IconButton(
                  onPressed: (){
                    context.read<SendSosCubit>().getMembers();
                  },
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.groups,
                        color: ConstantColors.primary,
                        size: 60,
                      ),
                      Text(
                        'Get the Organizations members which will receive the sos',
                        style: Styles.getDefaultPrimary(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {
                if(state is SendSosSuccess){
                  HelperFunctions.showSnackBar(context, 'SOS sent successfully');
                  Navigator.of(context).pushNamed(CancelSos.routeName);
                }
                else if(state is MemberReceivedFailure){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'An error occurred during fetching members'),
                    ),
                  );
                }
                else if(state is SendSosFailure){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'An error occurred during sending sos'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
