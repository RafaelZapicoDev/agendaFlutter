import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    super.onSaved,
    super.validator,
    bool super.initialValue = false,
    bool autovalidate = false,
    Color activeColor = Colors.blueAccent,
    Color checkColor = Colors.white,
    OutlinedBorder? shape,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: activeColor,
              checkColor: checkColor,
              shape: shape,
            );
          },
        );
}
