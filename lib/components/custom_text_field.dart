import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.controller,
      this.validator,
      this.hintText,
      this.value,
      required this.onChanged,
      this.color = primaryButtonColor,
      this.icon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      Key? key})
      : super(key: key);
  final String? value;
  final String? hintText;
  final Function(String value) onChanged;
  final Color? color;
  final IconData? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      // controller: TextEditingController(text: value),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      onChanged: (value) {
        onChanged(value);
      },
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        icon: (icon == null)
            ? null
            : Icon(
                icon,
                color: Colors.orangeAccent,
              ),
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? primaryButtonColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color ?? primaryButtonColor, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
