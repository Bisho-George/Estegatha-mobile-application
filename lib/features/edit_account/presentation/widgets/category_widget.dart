import 'package:estegatha/features/edit_account/presentation/widgets/preference_widget.dart';
import 'package:estegatha/utils/common/widgets/category_header_widget.dart';
import 'package:estegatha/responsive/size_config.dart';
import 'package:estegatha/utils/common/styles/text_styles.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/model/account_preferences.dart';
class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.name, required this.preferences});
  String name;
  List<AccountPreferences> preferences;
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryHeaderWidget(name: name),
          ListView(
            shrinkWrap: true,
            children: preferences.map((preference) => PreferencesWidget(preference: preference)).toList(),
          )
        ],
      ),
    );
  }
}
