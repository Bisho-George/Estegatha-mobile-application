import 'package:estegatha/features/sign-up/data/models/places_autocomplete_model/place_autocomplete_model.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_text_field_cubit.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/address_view_model.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressSearchResult extends StatelessWidget {
  const AddressSearchResult({
    super.key,
    required this.addressViewModel,
    required this.predictions
  });

  final AddressViewModel addressViewModel;
  final List<PlaceModel> predictions;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: responsiveHeight(150),
            color: Colors.white,
            child: RawScrollbar(
              thumbColor: ConstantColors.primary,
              radius: const Radius.circular(10),
              thickness: 5,
              interactive: true,
              controller: addressViewModel.scrollController,
              thumbVisibility: true,
              child: ListView.separated(
                      controller: addressViewModel.scrollController,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Image.asset(
                              ConstantImages.googleMapsIcon,
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            title: const Text("data"),
                            trailing: IconButton(
                              icon: const Icon(
                                  color: ConstantColors.primary,
                                  FontAwesomeIcons.circleRight),
                              onPressed: () {},
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemCount: predictions.length)
              ),
          ),
        ],
      ),
    );
  }
}
