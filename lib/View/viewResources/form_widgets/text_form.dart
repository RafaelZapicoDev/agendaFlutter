import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//text form personalizado
enum TextFormType { text, email, numero, password }

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextFormType type;
  final bool secret;
  final Function()? onTapius;
  final bool? readOnly;
  final String validatorMessage;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.type,
      required this.validatorMessage,
      required this.secret,
      this.onTapius,
      this.readOnly});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var logger = Logger();

  bool hidden = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      onTap: widget.onTapius,
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      obscureText: widget.secret ? !hidden : hidden,
      cursorColor: Colors.blueAccent,
      decoration: InputDecoration(
          suffixIcon: widget.secret
              ? IconButton(
                  icon: hidden
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.amber,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.amber,
                        ),
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                )
              : null,
          labelText: widget.labelText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 98, 160, 190)),
          ),
          labelStyle: const TextStyle(color: Colors.blueAccent)),
      validator: (value) {
        switch (widget.type) {
          case TextFormType.text:
            if (value == null || value.isEmpty) {
              return widget.validatorMessage;
            }
            return null;
          case TextFormType.email:
            if (value == null ||
                !EmailValidator.validate(value) ||
                !value.contains("@")) {
              return widget.validatorMessage;
            }
            return null;
          case TextFormType.numero:
            if (double.tryParse(value!) == null) {
              return widget.validatorMessage;
            }
            return null;
          case TextFormType.password:
            if (value == null || value.isEmpty) {
              return widget.validatorMessage;
            }
            if (value.length < 6) {
              return "A senha deve ter mais de 6 caracteres";
            }
        }
        return null;
      },
    );
  }
}
