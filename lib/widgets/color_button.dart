import 'package:flutter/material.dart';
import '../theme/theme_provider.dart';
import 'hoverable_button.dart';

class ColorButton extends StatelessWidget {
  final BuildContext context;
  final Color color;
  final bool isSelected;
  final ThemeNotifier themeNotifier;
  final bool isMobile;

  const ColorButton({
    required this.context,
    required this.color,
    required this.isSelected,
    required this.themeNotifier,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: HoverableButton(
        isSelected: isSelected,
        onTap: () {
          themeNotifier.setThemeColor(color);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xFFEFF1FA),
              width: 1,
            ),
          ),
          child: isSelected
              ? Icon(Icons.check, color: Color(0xFF161932), size: 18)
              : null,
        ),
      ),
    );
  }
}
