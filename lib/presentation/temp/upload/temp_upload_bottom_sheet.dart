import 'package:dally/data/enums.dart';
import 'package:dally/presentation/global_widgets.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:flutter/material.dart';

Widget tempUploadBottomSheet(
        {Function()? onClear, required Function(GalleryType type) onSelect}) =>
    bottomContainer([
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        button(
            onTap: onClear,
            child: const Icon(Icons.clear, size: 22),
            padding: const EdgeInsets.symmetric(vertical: 4))
      ]),
      const Text("등록하실 전시관을 선택하세요.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      const Text("업로드한 전시회 내에서 등록하신 작품은 랜덤으로 보여집니다.",
          style: TextStyle(fontSize: 12, color: ColorPalette.subText)),
      const SizedBox(height: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buttonItem(GalleryType.illustration, onTap: onSelect),
          Container(height: 1, color: ColorPalette.gray300),
          _buttonItem(GalleryType.drawing, onTap: onSelect),
          Container(height: 1, color: ColorPalette.gray300),
          _buttonItem(GalleryType.landscape, onTap: onSelect),
          Container(height: 1, color: ColorPalette.gray300),
          _buttonItem(GalleryType.portrait, onTap: onSelect),
          Container(height: 1, color: ColorPalette.gray300),
          _buttonItem(GalleryType.stillLife, onTap: onSelect),
        ],
      )
    ], padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36));

Widget _buttonItem(GalleryType type, {required Function(GalleryType) onTap}) =>
    SizedBox(
      width: double.infinity,
      child: button(
          onTap: () => onTap(type),
          child: Text(type.korean,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center),
          padding: const EdgeInsets.symmetric(vertical: 22)),
    );
