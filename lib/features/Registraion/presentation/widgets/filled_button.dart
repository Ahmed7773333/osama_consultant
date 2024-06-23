import 'package:flutter/material.dart';
import 'package:osama_consultant/core/utils/app_styles.dart';

Widget cusFilledButton(
    {required String name,
    required String icon,
    required VoidCallback onClick}) {
  return FilledButton.icon(
    style: FilledButton.styleFrom(
        backgroundColor: Colors.white, shape: const RoundedRectangleBorder()),
    onPressed: onClick,
    label: Text(name, style: AppStyles.smallLableStyle),
    icon: Image.asset(icon),
  );
}
