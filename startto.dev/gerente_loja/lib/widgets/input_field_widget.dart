import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.stream,
    required this.onChanged,
    this.isObscure = false,
  });

  final IconData icon;
  final String label;
  final bool isObscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              icon,
              color: Colors.white60,
            ),
            labelStyle: const TextStyle(
              color: Colors.white60,
            ),
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
          obscureText: isObscure,
        );
      },
    );
  }
}
