import 'package:flutter/material.dart';

import '../../resource/values/colors.dart';

class AnimatedNavigationBar extends StatelessWidget {
  const AnimatedNavigationBar(
      {Key? key,
      required this.items,
      required this.currentIndex,
      this.backgroundColor,
      this.indicatorColor,
      this.indicatorPadding,
      this.padding,
      this.onTap})
      : super(key: key);

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final EdgeInsets? padding;
  final EdgeInsets? indicatorPadding;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final _currentBarSize = MediaQuery.of(context).size.width / items.length;

    return Container(
        color: backgroundColor,
        padding: padding ??
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                children: items.map((e) {
              Widget nowIcon = e.icon;
              final i = items.indexOf(e);
              if (currentIndex == i) {
                nowIcon = e.activeIcon;
              }
              return Expanded(
                child: Material(
                  color: backgroundColor,
                  child: InkWell(
                    onTap: () => onTap?.call(i),
                    enableFeedback: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: nowIcon,
                    ),
                  ),
                ),
              );
            }).toList()),
            SizedBox(
              height: 3,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCirc,
                    left: currentIndex * _currentBarSize,
                    child: Container(
                        padding: indicatorPadding ??
                            EdgeInsets.symmetric(
                                horizontal: _currentBarSize / 10),
                        width: _currentBarSize,
                        child: Container(
                            height: 3,
                            color: indicatorColor ?? ColorPalette.white)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
