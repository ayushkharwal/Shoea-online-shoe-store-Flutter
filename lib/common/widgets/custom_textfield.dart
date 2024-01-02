import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.textEditingController,
    this.validator,
    this.readOnly,
    this.maxLength,
    this.label,
  });

  Icon? prefixIcon;
  Icon? suffixIcon;
  String? hintText;
  TextEditingController? textEditingController;
  var validator;
  bool? readOnly;
  int? maxLength;
  String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: textEditingController,
      validator: validator,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: Text(
          '$label',
        ),
        floatingLabelStyle:
            const TextStyle(color: kPrimaryColor1, fontWeight: FontWeight.bold),
        labelStyle: const TextStyle(color: kGrey3),
        filled: true,
        fillColor: kGrey1,
        prefixIcon: prefixIcon,
        prefixIconColor: MaterialStateColor.resolveWith(
          (states) =>
              states.contains(MaterialState.focused) ? kPrimaryColor1 : kGrey3,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: MaterialStateColor.resolveWith(
          (states) =>
              states.contains(MaterialState.focused) ? kPrimaryColor1 : kGrey3,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: kGrey3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
