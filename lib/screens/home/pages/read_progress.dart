import 'package:flutter/material.dart';
import 'package:library_app/themes.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color valueColor;

  const CustomLinearProgressIndicator({
    Key? key,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0, 
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.0),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: greyColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        ),
      ),
    );
  }
}
