import 'package:flutter/material.dart';

import '../resource/values/colors.dart';

Widget button({
  Function()? onTap,
  required Widget child,
  bool enable = true,
  EdgeInsets? padding,
  Color? color,
  Color? disabledColor,
  double? cornerRadius,
}) =>
    ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        child: Material(
            color: enable
                ? (color ?? ColorPalette.transparent)
                : (disabledColor ?? color),
            child: InkWell(
                onTap: enable ? onTap : null,
                child: Padding(
                    padding: padding ?? EdgeInsets.zero, child: child))));

Widget easyShadowBox({
  required Widget child,
  Color? shadowColor,
  double x = 2,
  double y = 4,
  double blur = 0.0,
  double spread = 0.0,
  double? radius,
}) =>
    Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: radius != null ? BorderRadius.circular(radius) : null,
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? ColorPalette.black.withOpacity(0.15),
                  offset: Offset(x, y),
                  blurRadius: blur,
                  spreadRadius: 2.0)
            ]),
        child: child);

Widget shadowButton({
  Function()? onTap,
  required Widget child,
  bool enable = true,
  Color? color,
  Color? disabledColor,
  double? radius,
  EdgeInsets? padding,
  Color? shadowColor,
  double? shadowBlur,
  double? shadowSpread,
}) =>
    easyShadowBox(
        x: 3,
        y: 3,
        blur: shadowBlur ?? 6,
        spread: shadowSpread ?? 0,
        shadowColor: shadowColor,
        child: button(
            child: child,
            enable: enable,
            disabledColor: disabledColor,
            color: color,
            cornerRadius: radius,
            padding: padding,
            onTap: onTap));

Widget input({
  TextEditingController? textEditingController,
  TextStyle? inputTextStyle,
  String? hint,
  TextStyle? hintStyle,
  EdgeInsets padding = EdgeInsets.zero,
  bool obscureText = false,
  int? maxLength,
  int? maxLine = 1,
  TextInputType? keyboardType,
  bool? enable = true,
}) =>
    TextField(
      style: inputTextStyle,
      controller: textEditingController,
      obscureText: obscureText,
      enabled: enable,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          border: InputBorder.none,
          isDense: true,
          contentPadding: padding,
          counterText: ""),
      maxLength: maxLength,
      maxLines: maxLine,
      keyboardType: keyboardType,
      cursorColor: ColorPalette.mainBlue,
    );

Widget underlineInput({
  TextEditingController? textEditingController,
  TextStyle? inputTextStyle,
  String? label,
  TextStyle? labelStyle = const TextStyle(color: ColorPalette.subText),
  String? hint,
  TextStyle? hintStyle = const TextStyle(color: ColorPalette.gray200),
  bool obscureText = false,
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12),
  int? maxLength,
  int? maxLine = 1,
  TextInputType? keyboardType,
  bool? enable = true,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label, style: labelStyle),
        if (label != null) const SizedBox(height: 2),
        input(
            textEditingController: textEditingController,
            inputTextStyle: inputTextStyle,
            hint: hint,
            hintStyle: hintStyle,
            obscureText: obscureText,
            maxLine: maxLine,
            maxLength: maxLength,
            keyboardType: keyboardType,
            enable: enable,
            padding: padding),
        Container(height: 1, color: ColorPalette.black),
      ],
    );

Widget bottomContainer(List<Widget> widgets,
        {EdgeInsets? padding = const EdgeInsets.only(top: 24)}) =>
    Wrap(children: [
      ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: Container(
              width: double.infinity,
              padding: padding,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets)))
    ]);
