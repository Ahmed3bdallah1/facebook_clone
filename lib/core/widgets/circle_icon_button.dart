import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: ColorsConstants.greyColor,
          radius: 20,
          child: FaIcon(
            icon,
            color: ColorsConstants.blackColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
