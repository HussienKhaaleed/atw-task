import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class textformfield extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const textformfield(
      {super.key,
      required this.hintText,
      this.isObscureText,
      this.suffixIcon,
      this.onChanged,
      this.onFieldSubmitted,
      this.keyboardType,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 18.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFEDEDED),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF07A66FF),
            width: 1.3.w,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Color(0xFFC2C2C2),
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: Color(0xFFFDFDFF),
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyle(
        fontSize: 14.sp,
        color: Color(0xFF07A66FF),
      ),
    );
  }
}
