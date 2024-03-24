import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.textEditingController,
    this.validator,
    this.readOnly,
    this.maxLength,
    this.label,
    this.onChanged,
    this.isObscured,
  });

  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? hintText;
  final TextEditingController? textEditingController;
  final validator;
  final bool? readOnly;
  final int? maxLength;
  final String? label;
  final onChanged;
  final bool? isObscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: textEditingController,
      validator: validator,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      onChanged: onChanged,
      obscureText: isObscured ?? false,
      decoration: InputDecoration(
        label: Text(
          '$label',
        ),
        floatingLabelStyle: const TextStyle(
          color: AppConstants.kPrimaryColor1,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: const TextStyle(color: AppConstants.kGrey3),
        filled: true,
        fillColor: AppConstants.kGrey1,
        prefixIcon: prefixIcon,
        prefixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.focused)
              ? AppConstants.kPrimaryColor1
              : AppConstants.kGrey3,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.focused)
              ? AppConstants.kPrimaryColor1
              : AppConstants.kGrey3,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppConstants.kGrey3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
