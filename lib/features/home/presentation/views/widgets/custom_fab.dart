
import 'package:estegatha/features/home/presentation/views/widgets/dangerous_dialog.dart';
import 'package:estegatha/utils/constant/colors.dart';
import 'package:estegatha/utils/constant/image_strings.dart';
import 'package:estegatha/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required Animation<Offset> slideAnimation,
    required bool isButtonVisible,
  }) : _slideAnimation = slideAnimation, _isButtonVisible = isButtonVisible;

  final Animation<Offset> _slideAnimation;
  final bool _isButtonVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: AnimatedOpacity(
            opacity: _isButtonVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                color: ConstantColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DangerousDialog(),
                  );
                },
                icon: SvgPicture.asset(
                  fit: BoxFit.cover,
                  ConstantImages.warningIcon,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        SlideTransition(
          position: _slideAnimation,
          child: AnimatedOpacity(
            opacity: _isButtonVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                color: ConstantColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  fit: BoxFit.cover,
                  ConstantImages.gpsIcon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
