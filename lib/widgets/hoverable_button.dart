import 'package:flutter/material.dart';

class HoverableButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  HoverableButton({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  _HoverableButtonState createState() => _HoverableButtonState();
}

class _HoverableButtonState extends State<HoverableButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? Color(0xFFEFF1FA) : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
