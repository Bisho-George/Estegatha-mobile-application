import 'package:estegatha/features/sos_alert/presentation/view_models/cubit/sos_index_cubit.dart';
import 'package:estegatha/features/sos_alert/presentation/view_models/sos_alert_into_view_model.dart';
import 'package:estegatha/features/sos_alert/presentation/views/widgets/moving_dot.dart';
import 'package:estegatha/utils/common/widgets/custom_elevated_button.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constant/sos_alert_constants.dart';

class SosAlertIntro extends StatelessWidget {
  SosAlertIntro({super.key});

  final SosAlertIntroViewModel sosAlertIntroViewModel =
  SosAlertIntroViewModel();

  static const String routeName = '/sos-alert-intro';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SosIndexCubit(),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          leading: Padding(
              padding: const EdgeInsets.only(left: ConstantSizes.spaceBtwItems),
              child: BlocBuilder<SosIndexCubit, SosIndexState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: ConstantColors.textPrimary,
                    ),
                    onPressed: () {
                      if (state is SosIndexChange && state.index > 0) {
                        BlocProvider.of<SosIndexCubit>(context)
                            .changeIndex(state.index - 1);
                        context
                            .read<SosIndexCubit>()
                            .pageController
                            ?.previousPage(duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              )),
          title: const Text('SOS',
              style: TextStyle(
                  color: ConstantColors.textPrimary,
                  fontSize: ConstantSizes.md,
                  fontWeight: ConstantSizes.fontWeightRegular)),
        ),
        body: Builder(
          builder: (context) {
            final pageController = context
                .read<SosIndexCubit>()
                .pageController;
            return PageView.builder(
              onPageChanged: (index) {
                context.read<SosIndexCubit>().changeIndex(index);
              },
              controller: pageController,
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: ConstantSizes.defaultSpace * 2,
                    left: ConstantSizes.defaultSpace,
                    right: ConstantSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: ConstantSizes.defaultSpace),
                      Text(
                        contents[index].sosDescription,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: ConstantSizes.lg,
                          fontWeight: ConstantSizes.fontWeightBold,
                          color: ConstantColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: ConstantSizes.defaultSpace),
                      Image.asset(
                        contents[index].sosImage,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems),
                      contents[index].sosInstruction == null
                          ? const SizedBox()
                          : Column(
                        children: contents[index]
                            .sosInstruction!
                            .map((instruction) =>
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: ConstantSizes.defaultSpace),
                              child: instruction,
                            ))
                            .toList(),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                              (dotIndex) =>
                              BlocBuilder<SosIndexCubit, SosIndexState>(
                                builder: (context, state) {
                                  return MovingDot(
                                    index: dotIndex,
                                    currentIndex:
                                    state is SosIndexChange ? state.index : 0,
                                  );
                                },
                              ),
                        ),
                      ),
                      SizedBox(height: ConstantSizes.defaultSpace),
                      contents[index].buttonText != null
                          ? CustomElevatedButton(
                        onPressed: () {
                          if (index == contents.length - 1) {
                            // Handle the last page button press
                            Navigator.pop(context);
                          } else {
                            pageController?.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        labelText: contents[index].buttonText!,
                      )
                          : SizedBox(height: ConstantSizes.defaultSpace * 2),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
