import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyContente extends StatelessWidget {
  const EmptyContente({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/undraw_No_data.svg',
            height: 100,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
