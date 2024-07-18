import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../providers/timer_provider.dart';
import '../theme/theme_provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/button_styles.dart';
import '../theme/spacing.dart';

class SettingsScreen extends ConsumerWidget {
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final Function(int) onPomodoroDurationChanged;
  final Function(int) onShortBreakDurationChanged;
  final Function(int) onLongBreakDurationChanged;
  final Function(Color) onColorChanged;
  final Function(String) onFontChanged;

  SettingsScreen({
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.onPomodoroDurationChanged,
    required this.onShortBreakDurationChanged,
    required this.onLongBreakDurationChanged,
    required this.onColorChanged,
    required this.onFontChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = Theme.of(context);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final buttonTextColor = themeNotifier.currentColor == Color(0xFF70F3F8)
        ? Color(0xFF1E213F)
        : Colors.white;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 464),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width < 539 ? 300 : 540,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.medium),
                          child: Text(
                            'Settings',
                            style: currentTheme.textTheme.headlineLarge!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Color(0xFF979797)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        height: 1.5,
                        color: Color(0xFF979797).withOpacity(0.25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.large),
                      child: Text(
                        'TIME (MINUTES)',
                        style: currentTheme.textTheme.headlineSmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildDropdownTimeAdjuster(
                            'pomodoro',
                            pomodoroDuration,
                            onPomodoroDurationChanged,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildDropdownTimeAdjuster(
                            'short break',
                            shortBreakDuration,
                            onShortBreakDurationChanged,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildDropdownTimeAdjuster(
                            'long break',
                            longBreakDuration,
                            onLongBreakDurationChanged,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: .9,
                        child: Container(
                          height: 1.5,
                          color: Color(0xFF979797).withOpacity(0.25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.medium,
                          horizontal: AppSpacing.large),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'FONT',
                            style: currentTheme.textTheme.headlineSmall!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildFontButton(
                                  context,
                                  'KumbhSans',
                                  currentTheme
                                          .textTheme.bodyLarge!.fontFamily ==
                                      'KumbhSans',
                                  () => onFontChanged('KumbhSans'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildFontButton(
                                  context,
                                  'RobotoSlab',
                                  currentTheme
                                          .textTheme.bodyLarge!.fontFamily ==
                                      'RobotoSlab',
                                  () => onFontChanged('RobotoSlab'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildFontButton(
                                  context,
                                  'SpaceMono',
                                  currentTheme
                                          .textTheme.bodyLarge!.fontFamily ==
                                      'SpaceMono',
                                  () => onFontChanged('SpaceMono'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: .9,
                        child: Container(
                          height: 1.5,
                          color: Color(0xFF979797).withOpacity(0.25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.medium,
                          horizontal: AppSpacing.large),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'COLOR',
                            style: currentTheme.textTheme.headlineSmall!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildColorButton(
                                  context,
                                  const Color(0xFFF87070),
                                  currentTheme.colorScheme.secondary ==
                                      const Color(0xFFF87070),
                                  themeNotifier,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildColorButton(
                                  context,
                                  const Color(0xFF70F3F8),
                                  currentTheme.colorScheme.secondary ==
                                      const Color(0xFF70F3F8),
                                  themeNotifier,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: _buildColorButton(
                                  context,
                                  const Color(0xFFD881F8),
                                  currentTheme.colorScheme.secondary ==
                                      const Color(0xFFD881F8),
                                  themeNotifier,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Adjust this to reduce space
                    SizedBox(
                        height: 35), // Reduced height to fit within constraints
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -25,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentTheme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    minimumSize: Size(150, 61),
                  ),
                  child: Text(
                    'Apply',
                    style: currentTheme.textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: buttonTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownTimeAdjuster(
      String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align label with the left corner
      children: [
        Text(label,
            style: TextStyle(
                color: Color(0xFF979797), fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          width: 140, // Set the width to 140
          decoration: BoxDecoration(
            color: Color(0xFFEFF1FA),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButton<int>(
            isExpanded: true, // Make sure the dropdown uses full width
            value: value,
            underline: SizedBox(),
            icon: Column(
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
            items: List.generate(60, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  value.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFontButton(BuildContext context, String fontFamily,
      bool isSelected, VoidCallback onTap) {
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
              fontSize: 16,
              color: isSelected ? Color(0xFFEFF1FA) : Color(0xFF161932),
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(BuildContext context, Color color, bool isSelected,
      ThemeNotifier themeNotifier) {
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
