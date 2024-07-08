import 'package:estegatha/features/safty/presentation/view_models/contact_cubit.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/model/contact_model.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({super.key, required this.contact});

  ContactModel contact;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      height: responsiveHeight(70),
      decoration: const BoxDecoration(
        color: ConstantColors.white,
        border: Border(
          bottom: BorderSide(
            color: ConstantColors.grey,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: responsiveWidth(16),
            top: responsiveHeight(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    contact.name,
                    style: Styles.getDefaultPrimary(
                      weight: ConstantSizes.fontWeightExtraBold,
                    )
                ),
                Text(
                    contact.phoneNumber,
                    style: Styles.getDefaultSecondary()
                ),
              ],
            ),
          ),
          Positioned(
            right: responsiveWidth(16),
            top: responsiveHeight(10),
            child: IconButton(
              icon: const Icon(Icons.delete,size: 30,color: Colors.red,),
              onPressed: () {
                BlocProvider.of<ContactCubit>(context).deleteContact(contact);
              },
            ),
          ),
        ],
      ),
    );
  }
}
