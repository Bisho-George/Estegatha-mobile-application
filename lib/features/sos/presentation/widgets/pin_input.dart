import 'package:estegatha/features/sos/presentation/widgets/pin_field.dart';
import 'package:flutter/material.dart';
class PinInput extends StatefulWidget {
  final void Function(String) onChange;
  const PinInput({Key? key, this.onChange = _defaultOnFinished}) : super(key: key);

  static void _defaultOnFinished(String pin) {}

  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (_controllers.every((controller) => controller.text.length == 1)) {
      final pin = _controllers.map((controller) => controller.text).join();
      widget.onChange(pin);
    }
    else{
      widget.onChange('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _controllers.map((controller) {
        final index = _controllers.indexOf(controller);
        return PinField(controller: controller, index: index);
      }).toList(),
    );
  }
}