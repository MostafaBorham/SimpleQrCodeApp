// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
      required this.controller,
      this.enabled = true,
      required this.obscureText,
      required this.keyboardType,
      this.validator,
      this.onChanged,
      this.isPassword = false,
      this.hintText})
      : super(key: key);
  final TextEditingController controller;
  bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final String? hintText;
  final bool enabled;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w300,
          ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.appWidth * AppWidth.s15,
          vertical: AppSizes.appHeight * AppHeight.s20,
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.deepOrange.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.deepOrange.shade300),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: Icon(widget.obscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w300,
            ),
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
