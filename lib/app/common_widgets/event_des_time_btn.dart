import 'package:flutter/cupertino.dart';

class EventDeswcriptionTimeButton extends StatelessWidget {

  final Color? textColor, backgroundColor;
   final String? buttonText;

  const EventDeswcriptionTimeButton({
    super.key, this.textColor, this.backgroundColor, this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 25,
       width: 100,
       decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor
       ),
       child: Center(child: Text(buttonText!,style: TextStyle(color: textColor,fontWeight: FontWeight.bold,fontSize: 15),))
    );
  }
}