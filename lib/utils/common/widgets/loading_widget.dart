import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.loading,
    required this.child,
  });

  final bool loading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      loading ? const CircularProgressIndicator() : Container(),
      Positioned(
        child: IgnorePointer(
          ignoring: loading,
          child: Opacity(
            opacity: loading ? 0.6 :  1,
            child: child
          ),
        ),
      ),
    ]);
  }
}
