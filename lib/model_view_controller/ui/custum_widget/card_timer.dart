import 'package:flutter/material.dart';
import 'package:Basme/model_view_controller/ui/style/size_config.dart';

class CartTimer extends StatelessWidget {
  const CartTimer({
    Key? key,
    this.time,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String? time;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // SvgPicture.asset(
        //   widget.selectedIcon,
        //   height: getProportionateScreenHeight(65),
        //   // color: kmaincolor,
        // ),

        Icon(
          icon,
          // Icons.hourglass_top,
          size: getProportionateScreenHeight(25),
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          time ?? '--:--',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        Text(
          title ?? '  ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(12),
          ),
        ),
      ],
    );
  }
}
