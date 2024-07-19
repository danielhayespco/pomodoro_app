import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'hoverable_icon.dart';

class DropdownTimeAdjuster extends StatefulWidget {
  final String label;
  final int value;
  final Function(int) onChanged;
  final bool isMobile;

  const DropdownTimeAdjuster({
    required this.label,
    required this.value,
    required this.onChanged,
    this.isMobile = false,
  });

  @override
  _DropdownTimeAdjusterState createState() => _DropdownTimeAdjusterState();
}

class _DropdownTimeAdjusterState extends State<DropdownTimeAdjuster> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(DropdownTimeAdjuster oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _selectedValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isMobile ? 140 : 140,
      height: widget.isMobile ? 40 : 48,
      decoration: BoxDecoration(
        color: Color(0xFFEFF1FA),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButton<int>(
        isExpanded: true,
        value: _selectedValue,
        dropdownColor: Color(0xFFEFF1FA),
        underline: SizedBox(),
        icon: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HoverableIcon(
                icon: Transform.rotate(
                  angle: 270 * math.pi / 180,
                  child: Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF979797), size: 14),
                ),
              ),
              HoverableIcon(
                icon: Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF979797), size: 14),
                ),
              ),
            ],
          ),
        ),
        items: List.generate(60, (index) => index + 1)
            .map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(
              value.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: widget.isMobile ? 14 : 16,
              ),
            ),
          );
        }).toList(),
        onChanged: (int? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
      ),
    );
  }
}
