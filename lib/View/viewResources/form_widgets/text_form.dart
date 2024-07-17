import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

enum TextFormType {
  text,
  email,
  numero,
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextFormType type;
  bool? obscure;
  final String validatorMessage;

  CustomTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.type,
      required this.validatorMessage,
      this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscure ?? false,
      cursorColor: Colors.blueAccent,
      decoration: InputDecoration(
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
