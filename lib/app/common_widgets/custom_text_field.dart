import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/common_widgets/my_form_field.dart';


class CustomTextField extends StatelessWidget {
  final int? maxLines, minLines;
  final String? inputHint;
  final Widget? suffixIcon, prefixIcon;
  final bool? obscureText;
  final TextInputType? inputKeyBoardType;
  final Color? inputFillColor;
  final InputBorder? border, focusedBorder, enabledBorder;
  final Function()? pressMe;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final bool? readOnly;
  final bool? enable;

  const CustomTextField({
    super.key,
    this.inputHint,
    this.suffixIcon,
    this.obscureText,
    this.inputKeyBoardType,
    this.inputFillColor,
    this.prefixIcon,
    this.border,
    this.pressMe,
    this.validator,
    this.controller,
    this.maxLines,
    this.minLines,
    this.hintStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.onChanged,
    this.readOnly,
     this.enable=true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyFormField(
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            controller: controller,
            validator: validator,
            inputFilled: true,
            inputFillColor: inputFillColor ?? Color(0xFF333649),
            inputHint: inputHint,
            obscureText: obscureText,
            inputKeyboardType: inputKeyBoardType,
            enable: enable,
            contentPadding: const EdgeInsets.only(
              top: 10,
              left: 19,
              right: 22,
              bottom: 10,
              
            ),
            border: border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color:Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                      color:Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(14),
                ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: suffixIcon,
            ),
            onChanged: onChanged,
            prefixIcon: prefixIcon,
            inputTextStyle: TextStyle(fontSize: 20,color: Colors.white),
            inputHintStyle: TextStyle(fontSize: 20,color: Colors.white), 
          ),
          // AppSizing.h04
        ],
      ),
    );
  }
}