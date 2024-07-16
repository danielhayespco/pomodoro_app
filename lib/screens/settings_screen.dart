import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../timer_provider.dart';
import '../theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final Function(int) onPomodoroDurationChanged;
  final Function(int) onShortBreakDurationChanged;
  final Function(int) onLongBreakDurationChanged;
  final Function(Color) onColorChanged;

  SettingsScreen({
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.onPomodoroDurationChanged,
    required this.onShortBreakDurationChanged,
    required this.onLongBreakDurationChanged,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width < 610 ? 300 : 600,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Settings',
                      style: currentTheme.textTheme.headlineLarge!
                          .copyWith(color: Colors.black)),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Text('TIME (MINUTES)',
                  style: currentTheme.textTheme.bodyLarge!
                      .copyWith(color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDropdown(
                    'pomodoro',
                    pomodoroDuration,
                    onPomodoroDurationChanged,
                  ),
                  _buildDropdown(
                    'short break',
                    shortBreakDuration,
                    onShortBreakDurationChanged,
                  ),
                  _buildDropdown(
                    'long break',
                    longBreakDuration,
                    onLongBreakDurationChanged,
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FONT',
                      style: currentTheme.textTheme.bodyLarge!
                          .copyWith(color: Colors.black)),
                  Row(
                    children: [
                      _buildFontButton(
                          context,
                          'Aa',
                          currentTheme.textTheme.bodyLarge!.fontFamily ==
                              'KumbhSans'),
                      _buildFontButton(
                          context,
                          'Aa',
                          currentTheme.textTheme.bodyLarge!.fontFamily ==
                              'RobotoSlab'),
                      _buildFontButton(
                          context,
                          'Aa',
                          currentTheme.textTheme.bodyLarge!.fontFamily ==
                              'SpaceMono'),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('COLOR',
                      style: currentTheme.textTheme.bodyLarge!
                          .copyWith(color: Colors.black)),
                  Row(
                    children: [
                      _buildColorButton(
                        context,
                        const Color(0xFFF87070),
                        currentTheme.colorScheme.secondary ==
                            const Color(0xFFF87070),
                      ),
                      _buildColorButton(
                        context,
                        const Color(0xFF70F3F8),
                        currentTheme.colorScheme.secondary ==
                            const Color(0xFF70F3F8),
                      ),
                      _buildColorButton(
                        context,
                        const Color(0xFFD881F8),
                        currentTheme.colorScheme.secondary ==
                            const Color(0xFFD881F8),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.black)),
        DropdownButton<int>(
          value: value,
          items: [5, 10, 15, 20, 25, 30]
              .map((int val) => DropdownMenuItem<int>(
                    value: val,
                    child: Text('$val', style: TextStyle(color: Colors.black)),
                  ))
              .toList(),
          onChanged: (newVal) {
            if (newVal != null) {
              onChanged(newVal);
            }
          },
        ),
      ],
    );
  }

  Widget _buildFontButton(BuildContext context, String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(text,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            // Handle font change
            // Make sure fonts are being downloaded
          }
        },
        selectedColor: const Color(0xFFF87070),
      ),
    );
  }

  Widget _buildColorButton(BuildContext context, Color color, bool isSelected) {
    return IconButton(
      icon: Icon(Icons.circle, color: color),
      onPressed: () => onColorChanged(color),
      iconSize: 36,
      color: isSelected ? Colors.white : color,
    );
  }
}
