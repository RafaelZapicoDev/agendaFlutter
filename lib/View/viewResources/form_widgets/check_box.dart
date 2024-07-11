import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {super.key,
      Widget? title,
      super.onSaved,
      super.validator,
      bool super.initialValue = false,
      bool autovalidate = false})
      : super(builder: (FormFieldState<bool> state) {
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
          );
        });
}
