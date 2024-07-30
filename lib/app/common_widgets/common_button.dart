
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/common_widgets/tap_effect.dart';

import '../app_theme/text_styles.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor, backgroundColor;
  final bool? isClickable;
  final double radius;
  final double? height;
  final double? width;
  final bool isIcon;
  final IconData? icon;
  const CommonButton({
    super.key,
    this.onTap,
    this.buttonText,
    this.buttonTextWidget,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.padding,
    this.isClickable = true,
    this.radius = 29,
    this.height = 40,
    this.width=40,
    this.icon = Icons.arrow_forward,
    this.isIcon = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TapEffect(
        isClickable: isClickable!,
        onClick: onTap ?? () {},
        child: SizedBox(
          height: height??40,
          width: width??40,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF760ABE), Color(0xFFB74BFF)], // Define your gradient colors here
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            // color: backgroundColor ?? Theme.of(context).primaryColor,
            child: (isIcon)?Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonTextWidget ??
                    Text(
                      buttonText ?? "",
                      style: TextStyles(context).getRegularStyle().copyWith(
                          color: textColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                Icon(icon,color: Colors.white,size: 15,)
              ],
            ): Center(
              child: buttonTextWidget ??
                  Text(
                    buttonText ?? "",
                    style: TextStyles(context).googleRubikFontsForButtonText(),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
