import 'package:flutter/material.dart';
import 'package:Basme/model_view_controller/ui/style/size_config.dart';

InputDecoration inputDecoration() {
  return InputDecoration(
    // hintStyle: TextStyle(
    //     color: Colors.grey, fontSize: getProportionateScreenHeight(20)),
    labelStyle: TextStyle(
      color: Colors.grey,
      fontSize: getProportionateScreenHeight(14),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    fillColor: Colors.grey[50],
    filled: true,

    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 10,
    ),

    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: BorderSide(
    //     color: Colors.grey,
    //   ),
    // ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.green.shade700,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
      borderSide: BorderSide(
        color: Colors.green.shade50,
      ),
    ),
  );
}
