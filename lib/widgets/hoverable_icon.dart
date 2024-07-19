import 'package:flutter/material.dart';

class HoverableIcon extends StatefulWidget {
  final Widget icon;

  HoverableIcon({required this.icon});

  @override
  _HoverableIconState createState() => _HoverableIconState();
}

class _HoverableIconState extends State<HoverableIcon> {
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
      child: IconTheme(
        data: IconThemeData(
          color: _isHovered ? Color(0xFF161932) : Color(0xFF979797),
        ),
        child: widget.icon,
      ),
    );
  }
}
