import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String text;
  const ProfileField({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Color.fromARGB(228, 56, 77, 87), fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.only(left: 20)),
            Text(text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 88, 115, 128), fontSize: 20))
          ],
        ),
      ],
    );
  }
}
