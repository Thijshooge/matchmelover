import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon; // LET OP: veranderd van IconData naar Widget
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.white), // witte tekstkleur
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ), // hintkleur iets lichter
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.white) // witte icon kleur
            : null,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 236, 28, 36), // Rood accentkleur
            width: 2,
          ), // Witte border als je op het veld klikt
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ), // Grijze border als het veld niet actief is
        ),
        filled: true,
        fillColor: Colors.black, // transparante achtergrond
      ),
    );
  }
}
