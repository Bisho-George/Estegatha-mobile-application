import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estegatha/features/home/presentation/view_models/home_view_model.dart';

class CustomPersonAppBar extends StatelessWidget {
  const CustomPersonAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<HomeCubit>().hideToggleBar();
          context.read<HomeCubit>().updateZoom(15);
        },
      ),
      title: const Text('Bishoy'),
    );
  }
}
