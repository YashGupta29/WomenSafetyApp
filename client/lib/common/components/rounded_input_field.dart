import 'package:flutter/material.dart';
import '../constants/colors.constants.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController fieldValue;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    this.validator,
    required this.fieldValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: fieldValue,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
            borderSide: const BorderSide(
              color: primaryLightColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
            borderSide: const BorderSide(
              color: primaryLightColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
            borderSide: const BorderSide(
              color: primaryLightColor,
            ),
          ),
          filled: true,
          fillColor: primaryLightColor,
        ),
      ),
    );
  }
}
