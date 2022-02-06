import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:Basme/model_view_controller/style/size_config.dart';

class Defaultbutton extends StatelessWidget {
  const Defaultbutton({
    this.color,
    this.height,
    this.width,
    this.onTap,
    this.textcolor,
    required this.text,
    this.haveBorder,
    this.haveIcon,
    this.icon,
    this.border,
    Key? key,
  }) : super(key: key);

  final void Function()? onTap;

  final double? height;
  final double? width;
  final BorderDirectional? border;

  final Color? color;

  final String text;

  final Color? textcolor;
  final bool? haveBorder;
  final bool? haveIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 30),
        width: width,
        height: height ?? getProportionateScreenHeight(50),
        decoration: BoxDecoration(
          border: (haveBorder ?? false)
              ? Border.all(color: textcolor ?? Colors.black)
              : border,
          // borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),

        //   BackdropFilter(
        // filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: border != null
                ? BorderRadius.circular(0)
                : BorderRadius.circular(8),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    color: textcolor ?? Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 2,
              ),
              if (haveIcon ?? false)
                Icon(
                  icon ?? Icons.arrow_forward_rounded,
                  color: textcolor,
                  size: getProportionateScreenHeight(20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
