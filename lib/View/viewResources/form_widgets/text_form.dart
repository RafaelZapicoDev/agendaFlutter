import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

//text form personalizado
enum TextFormType {
  text,
  email,
  numero,
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextFormType type;
  final bool secret;
  final Function()? onTapius;
  final bool? readOnly;
  bool hidden = false;

  final String validatorMessage;

  CustomTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.type,
      required this.validatorMessage,
      required this.secret,
      this.onTapius,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      onTap: onTapius,
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: secret ? secret : false,
      cursorColor: Colors.blueAccent,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                hidden = !hidden;
              },
              icon: hidden!
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.amber,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.amber,
                    )),
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 98, 160, 190)),
          ),
          labelStyle: const TextStyle(color: Colors.blueAccent)),
      validator: (value) {
        switch (type) {
          case TextFormType.text:
            if (value == null || value.isEmpty) {
              return validatorMessage;
            }
            return null;
          case TextFormType.email:
            if (value == null ||
                !EmailValidator.validate(value) ||
                !value.contains("@")) {
              return validatorMessage;
            }
            return null;
          case TextFormType.numero:
            if (double.tryParse(value!) == null) {
              return validatorMessage;
            }
            return null;
        }
      },
    );
  }
}
