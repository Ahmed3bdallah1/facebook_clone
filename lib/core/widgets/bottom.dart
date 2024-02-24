import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {super.key,
        required this.onPressed,
        required this.label,
        this.color = ColorsConstants.lightBlueColor,
        this.height = 50,
        this.width,
        this.radius,
        this.icon});

  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final double height;
  final double? width;
  final double? radius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: onPressed == null ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(radius ?? 25),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null
                  ? Container(
                width: 0,
              )
                  : Icon(
                icon,
                size: 16,
                color: (color == ColorsConstants.lightBlueColor)
                    ? ColorsConstants.realWhiteColor
                    : Colors.black,
              ),
              const SizedBox(width: 2),
              Text(
                label,
                style: TextStyle(
                  color: (color == ColorsConstants.lightBlueColor &&
                      onPressed != null)
                      ? ColorsConstants.realWhiteColor
                      : null,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
