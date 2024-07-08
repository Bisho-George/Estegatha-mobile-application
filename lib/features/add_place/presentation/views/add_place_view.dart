import 'package:flutter/material.dart';

import '../../../../utils/constant/colors.dart';

class AddPlaceView extends StatelessWidget {
  const AddPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
        appBar: AppBar(
          title: const Text('Places', style: TextStyle(
            color: ConstantColors.primary,
            fontSize: ConstantSizes,

    )),
        ),
        body: const Center(
          child: Text('Add Place'),
        ),
      ),;
  }
}
