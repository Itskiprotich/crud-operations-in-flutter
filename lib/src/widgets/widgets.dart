
import 'package:crud/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

InputDecoration inputDecoration({required String label, required String prefixText}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: appTextColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color:appTextColor),
    ),
    filled: true,
    fillColor: appTextColor,
    labelText: label,
    labelStyle: secondaryTextStyle(),
    prefixText: prefixText,
    alignLabelWithHint: true,
  );
}