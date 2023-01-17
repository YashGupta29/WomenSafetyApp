import 'package:flutter/material.dart';
import '../constants/colors.constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController fieldValue;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.validator,
    required this.fieldValue,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: TextFormField(
      obscureText: _isVisible ? false : true,
      controller: widget.fieldValue,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        hintText: "Password",
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Icon(
            Icons.lock,
            color: primaryColor,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
          child: GestureDetector(
            child: Icon(
              _isVisible ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
    ));
  }
}
