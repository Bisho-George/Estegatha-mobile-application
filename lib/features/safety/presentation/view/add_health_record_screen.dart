// import 'package:estegatha/utils/common/custom_app_bar.dart';
// import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
// import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
// import 'package:estegatha/utils/helpers/responsive.dart';
// import 'package:estegatha/utils/constant/colors.dart';
// import 'package:estegatha/utils/constant/sizes.dart';

// class AddHealthRecordScreen extends StatefulWidget {
//   const AddHealthRecordScreen({super.key});

//   @override
//   _AddHealthRecordScreenState createState() => _AddHealthRecordScreenState();
// }

// class _AddHealthRecordScreenState extends State<AddHealthRecordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? selectedDisease;
//   final List<String> diseases = [
//     'Diabetes',
//     'Kidney',
//     'Cancer',
//     'Chronic respiratory disease',
//     'Asthma',
//     'Inflammatory Bowel',
//     'Heart disease',
//     'Hypertension'
//   ];
//   final TextEditingController otherDiseaseController = TextEditingController();
//   final TextEditingController medicalHistoryController =
//       TextEditingController();
//   final TextEditingController medicineController = TextEditingController();

//   void submitDisease() {
//     if (selectedDisease != null || otherDiseaseController.text.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Disease information submitted')),
//       );
//       // Perform submission logic for disease information
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter disease information')),
//       );
//     }
//   }

//   void submitMedicine() {
//     if (medicineController.text.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Medicine information submitted')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter medicine information')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         leadingIcon: Icons.arrow_back,
//         leadingOnPressed: () {
//           Navigator.pop(context, true);
//         },
//         title: Text(
//           "Add Health Record",
//           style: TextStyle(
//             fontSize: SizeConfig.font20,
//             color: ConstantColors.primary,
//           ),
//         ),
//         showBackArrow: false,
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionHeading(title: "Diseases"),
//               SizedBox(
//                 height:
//                     getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedDisease,
//                       hint: const Text('Select disease'),
//                       items: [
//                         const DropdownMenuItem<String>(
//                           value: '',
//                           child: Text('...'),
//                         ),
//                         ...diseases.map((String disease) {
//                           return DropdownMenuItem<String>(
//                             value: disease,
//                             child: Text(disease),
//                           );
//                         }),
//                       ],
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           if (newValue == '') {
//                             selectedDisease = null;
//                           } else {
//                             selectedDisease = newValue;
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               ConstantSizes.inputFieldRadius),
//                           borderSide: const BorderSide(
//                               width: 1, color: ConstantColors.textInputBorder),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               ConstantSizes.inputFieldRadius),
//                           borderSide: const BorderSide(
//                               width: 1, color: ConstantColors.textInputBorder),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               ConstantSizes.inputFieldRadius),
//                           borderSide: const BorderSide(
//                               width: 1, color: ConstantColors.borderPrimary),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               ConstantSizes.inputFieldRadius),
//                           borderSide: const BorderSide(
//                               width: 1, color: ConstantColors.warning),
//                         ),
//                         focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               ConstantSizes.inputFieldRadius),
//                           borderSide: const BorderSide(
//                               width: 2, color: ConstantColors.warning),
//                         ),
//                         labelStyle: const TextStyle(
//                           fontSize: ConstantSizes.fontSizeMd,
//                           color: ConstantColors.darkGrey,
//                         ),
//                         hintStyle: const TextStyle(
//                           fontSize: ConstantSizes.fontSizeMd,
//                           color: ConstantColors.darkGrey,
//                         ),
//                         errorStyle: const TextStyle(
//                           fontStyle: FontStyle.normal,
//                         ),
//                         floatingLabelStyle: TextStyle(
//                           color: ConstantColors.primary.withOpacity(0.8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: getProportionateScreenHeight(
//                           ConstantSizes.spaceBtwInputFields),
//                     ),
//                     CustomTextField(
//                       controller: otherDiseaseController,
//                       onChanged: (value) {
//                         setState(() {
//                           value = otherDiseaseController.text;
//                         });
//                       },
//                       labelText: 'Other Disease',
//                       hintText: 'Enter other disease',
//                     ),
//                     SizedBox(
//                       height: getProportionateScreenHeight(
//                           ConstantSizes.spaceBtwInputFields),
//                     ),
//                     CustomElevatedButton(
//                         onPressed: otherDiseaseController.text.isNotEmpty ||
//                                 selectedDisease != null
//                             ? submitDisease
//                             : null,
//                         labelText: "Save Disease"),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height:
//                     getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
//               ),
//               const SectionHeading(title: "Medicine and Medical History"),
//               SizedBox(
//                 height:
//                     getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CustomTextField(
//                       onChanged: (value) {
//                         setState(() {
//                           value = medicineController.text;
//                         });
//                       },
//                       controller: medicineController,
//                       labelText: 'Medicine',
//                       hintText: 'Enter the medicines you take',
//                     ),
//                     SizedBox(
//                       height: getProportionateScreenHeight(
//                           ConstantSizes.spaceBtwInputFields),
//                     ),
//                     CustomElevatedButton(
//                         onPressed: medicineController.text.isNotEmpty
//                             ? submitMedicine
//                             : null,
//                         labelText: "Save Medicine"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'package:estegatha/utils/common/custom_app_bar.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/features/organization/presentation/view/widgets/section_heading.dart';
import 'package:estegatha/utils/common/widgets/custom_text_field.dart';
import 'package:estegatha/utils/helpers/responsive.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';

class AddHealthRecordScreen extends StatefulWidget {
  const AddHealthRecordScreen({Key? key}) : super(key: key);

  @override
  _AddHealthRecordScreenState createState() => _AddHealthRecordScreenState();
}

class _AddHealthRecordScreenState extends State<AddHealthRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDisease;
  final List<String> diseases = [
    'Diabetes',
    'Kidney',
    'Cancer',
    'Chronic respiratory disease',
    'Asthma',
    'Inflammatory Bowel',
    'Heart disease',
    'Hypertension'
  ];
  final TextEditingController otherDiseaseController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();

  void submitDisease() {
    if (selectedDisease != null || otherDiseaseController.text.isNotEmpty) {
      final disease = selectedDisease ?? otherDiseaseController.text;
      context.read<UserHealthCubit>().addUserDisease(disease);
      HelperFunctions.showSnackBar(context, 'Disease information saved');

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter disease information')),
      );
    }
  }

  void submitMedicine() {
    if (medicineController.text.isNotEmpty) {
      context.read<UserHealthCubit>().addUserMedicine(medicineController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter medicine information')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.arrow_back,
        leadingOnPressed: () {
          Navigator.pop(context, true);
        },
        title: Text(
          "Add Health Record",
          style: TextStyle(
            fontSize: SizeConfig.font20,
            color: ConstantColors.primary,
          ),
        ),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: "Diseases"),
              SizedBox(
                height:
                    getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedDisease,
                      hint: const Text('Select disease'),
                      items: [
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('Clear selection'),
                        ),
                        ...diseases.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          if (newValue == '') {
                            selectedDisease = null;
                          } else {
                            selectedDisease = newValue;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ConstantSizes.inputFieldRadius),
                          borderSide: const BorderSide(
                              width: 1, color: ConstantColors.textInputBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ConstantSizes.inputFieldRadius),
                          borderSide: const BorderSide(
                              width: 1, color: ConstantColors.textInputBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ConstantSizes.inputFieldRadius),
                          borderSide: const BorderSide(
                              width: 1, color: ConstantColors.borderPrimary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ConstantSizes.inputFieldRadius),
                          borderSide: const BorderSide(
                              width: 1, color: ConstantColors.warning),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ConstantSizes.inputFieldRadius),
                          borderSide: const BorderSide(
                              width: 2, color: ConstantColors.warning),
                        ),
                        labelStyle: const TextStyle(
                          fontSize: ConstantSizes.fontSizeMd,
                          color: ConstantColors.darkGrey,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: ConstantSizes.fontSizeMd,
                          color: ConstantColors.darkGrey,
                        ),
                        errorStyle: const TextStyle(
                          fontStyle: FontStyle.normal,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: ConstantColors.primary.withOpacity(0.8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          ConstantSizes.spaceBtwInputFields),
                    ),
                    CustomTextField(
                      controller: otherDiseaseController,
                      onChanged: (value) {
                        setState(() {
                          value = otherDiseaseController.text;
                        });
                      },
                      labelText: 'Other Disease',
                      hintText: 'Enter other disease',
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          ConstantSizes.spaceBtwInputFields),
                    ),
                    CustomElevatedButton(
                      onPressed: otherDiseaseController.text.isNotEmpty ||
                              selectedDisease != null
                          ? submitDisease
                          : null,
                      labelText: "Save Disease",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
              ),
              const SectionHeading(title: "Medicine and Medical History"),
              SizedBox(
                height:
                    getProportionateScreenHeight(ConstantSizes.spaceBtwItems),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ConstantSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextField(
                      onChanged: (value) {
                        setState(() {
                          value = medicineController.text;
                        });
                      },
                      controller: medicineController,
                      labelText: 'Medicine',
                      hintText: 'Enter the medicines you take',
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(
                          ConstantSizes.spaceBtwInputFields),
                    ),
                    CustomElevatedButton(
                      onPressed: medicineController.text.isNotEmpty
                          ? submitMedicine
                          : null,
                      labelText: "Save Medicine",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
