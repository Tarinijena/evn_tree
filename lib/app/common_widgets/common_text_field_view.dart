import 'package:flutter/material.dart';

import '../app_theme/text_styles.dart';

class CommonTextFieldView extends StatelessWidget {
  final String? titleText;
  final int? maxLength;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final bool? enable;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final double? pad;
  final double? height;
  final double? radius;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final Color? borderColor;
  final IconData? suffixIcon;
  final BuildContext? contextNew;

  const CommonTextFieldView(
      {super.key,
      this.hintText = '',
      this.isObscureText = false,
      this.padding =
          const EdgeInsets.only(bottom: 0, right: 0, top: 0, left: 0),
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.isAllowTopTitleView = true,
      this.errorText,
      this.titleText = '',
      this.controller,
      this.maxLength,
      this.pad = 16,
      this.radius = 10,
      this.contextNew,
      this.height = 50,
        this.suffixIcon,
        this.suffixIconSize,
        this.borderColor,
      this.enable = true, required this.suffixIconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height ?? 50,
        child: Center(
          child: TextField(
            
            controller: controller,
            maxLines: 1,
            enabled: enable,
            onChanged: onChanged,
            maxLength: maxLength ?? 50,
            style: TextStyles(context).googleRubikFontsForButtonText(),
            obscureText: isObscureText,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
                errorText: null,
                counterText: "",
                // border: InputBorder.none,
                // hintText: hintText,
                labelText: hintText,
                labelStyle: TextStyles(context).googleRubikFontsForButtonText(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius??10),
                    borderSide: const BorderSide(color: Color(0xFF333649),width: 1)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius??10),
                    borderSide: const BorderSide(color: Color(0xFF333649),width: 1)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius??10),
                    borderSide: const BorderSide(color: Color(0xFF333649),width: 1)
                ),
                fillColor: const Color(0xFF171224),
                contentPadding: const EdgeInsets.only(left: 16,right: 14,top: 2,bottom: 2),
                filled: true,
                suffixIcon:  Icon(suffixIcon??Icons.email_outlined,size: 18,color: suffixIconColor??const  Color(0xFFB74BFF) ,)
            ),
            keyboardType: keyboardType,
            
          ),
        ),
      ),
    );
  }
}


