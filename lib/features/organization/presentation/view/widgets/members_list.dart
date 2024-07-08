import 'package:estegatha/features/organization/domain/models/organizationMember.dart';
import 'package:estegatha/features/organization/presentation/view/main/track_cubit/track_cubit.dart';
import 'package:estegatha/features/tracking/presentation/view/order_tracking_screen.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MembersList extends StatelessWidget {
  final List<OrganizationMember> members;
  final String badgeLabel;

  const MembersList({required this.members, required this.badgeLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        OrganizationMember member = members[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: ConstantColors.grey,
                width: 0.5.w,
              ),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                member.username![0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              member.username!,
              style: const TextStyle(
                color: ConstantColors.primary,
                fontSize: ConstantSizes.fontSizeLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Member ID: ${member.userId}'),
            trailing: SizedBox(
              height: 28.0.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ConstantColors.primary,
                ),
                child: Text(
                  badgeLabel,
                  style: const TextStyle(
                      color: ConstantColors.white, letterSpacing: 0.75),
                ),
                onPressed: () {
                  if (badgeLabel == 'Track') {
                    context.read<TrackCubit>().toggleLocationTracking();
                    context
                        .read<TrackCubit>()
                        .setNameOfTheTrackedMember(member.username!);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const OrderTrackingScreen(),
                    //   ),
                    // );
                  }
                  // Handle track button press
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
