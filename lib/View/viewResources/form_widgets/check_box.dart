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
              fillColor: WidgetStateColor.resolveWith((states) {
                return Color.fromARGB(255, 220, 238, 247);
              }),
              activeColor: Colors.blueAccent,
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: checkColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Color.fromARGB(255, 98, 160, 190),
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        );
}
