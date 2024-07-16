import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width < 610 ? 300 : 600,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.small),
                        child: Text('Settings',
                            style: currentTheme.textTheme.headlineLarge!
                                .copyWith(color: Colors.black)),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.small),
                    child: Text('TIME (MINUTES)',
                        style: currentTheme.textTheme.headlineSmall!
                            .copyWith(color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimeAdjuster(
                        'pomodoro',
                        pomodoroDuration,
                        onPomodoroDurationChanged,
                      ),
                      _buildTimeAdjuster(
                        'short break',
                        shortBreakDuration,
                        onShortBreakDurationChanged,
                      ),
                      _buildTimeAdjuster(
                        'long break',
                        longBreakDuration,
                        onLongBreakDurationChanged,
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.small),
                    child: Text('FONT',
                        style: currentTheme.textTheme.headlineSmall!
                            .copyWith(color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      Row(
                        children: [
                          _buildFontButton(
                            context,
                            'KumbhSans',
                            currentTheme.textTheme.bodyLarge!.fontFamily ==
                                'KumbhSans',
                            () => onFontChanged('KumbhSans'),
                          ),
                          _buildFontButton(
                            context,
                            'RobotoSlab',
                            currentTheme.textTheme.bodyLarge!.fontFamily ==
                                'RobotoSlab',
                            () => onFontChanged('RobotoSlab'),
                          ),
                          _buildFontButton(
                            context,
                            'SpaceMono',
                            currentTheme.textTheme.bodyLarge!.fontFamily ==
                                'SpaceMono',
                            () => onFontChanged('SpaceMono'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.small),
                    child: Text('COLOR',
                        style: currentTheme.textTheme.headlineSmall!
                            .copyWith(color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      Row(
                        children: [
                          _buildColorButton(
                            context,
                            const Color(0xFFF87070),
                            currentTheme.colorScheme.secondary ==
                                const Color(0xFFF87070),
                            themeNotifier,
                          ),
                          _buildColorButton(
                            context,
                            const Color(0xFF70F3F8),
                            currentTheme.colorScheme.secondary ==
                                const Color(0xFF70F3F8),
                            themeNotifier,
                          ),
                          _buildColorButton(
                            context,
                            const Color(0xFFD881F8),
                            currentTheme.colorScheme.secondary ==
                                const Color(0xFFD881F8),
                            themeNotifier,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.large),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentTheme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: Size(140, 53),
                  ),
                  child: Text('Apply',
                      style: currentTheme.textTheme.bodyLarge!
                          .copyWith(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAdjuster(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.black)),
        Container(
          color: const Color(0xEFF1FA),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text('$value', style: TextStyle(color: Colors.black)),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_drop_up, color: Colors.black),
                    onPressed: () {
                      onChanged(value + 1);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    onPressed: () {
                      onChanged(value - 1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFontButton(BuildContext context, String fontFamily,
      bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF161932) : Color(0xFFEFF1FA),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'Aa',
            style: TextStyle(
              color: isSelected ? Color(0xFFEFF1FA) : Color(0xFF161932),
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(BuildContext context, Color color, bool isSelected,
      ThemeNotifier themeNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
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
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
          child:
              isSelected ? Icon(Icons.check, color: Color(0xFF161932)) : null,
        ),
      ),
    );
  }
}
