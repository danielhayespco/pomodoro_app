import 'package:flutter/material.dart';
import 'hoverable_button.dart';

class FontButton extends StatelessWidget {
  final BuildContext context;
  final String fontFamily;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isMobile;

  const FontButton({
    required this.context,
    required this.fontFamily,
    required this.isSelected,
    required this.onTap,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: HoverableButton(
        isSelected: isSelected,
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF161932) : Color(0xFFEFF1FA),
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xFFEFF1FA),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'Aa',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: isSelected ? Color(0xFFEFF1FA) : Color(0xFF161932),
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
