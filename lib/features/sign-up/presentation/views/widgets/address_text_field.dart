import 'package:flutter/material.dart';
import '../../../../../utils/common/widgets/custom_text_field.dart';

class AddressTextField extends StatelessWidget {

  final TextEditingController controller;
  final Function(String)? onChanged;
  AddressTextField({Key? key, required this.controller, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "Address",
      hintText: "Your address",
      keyboardType: TextInputType.text,
      prefixIcon: Icon(Icons.location_on),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
