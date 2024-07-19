import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../providers/timer_provider.dart';
import '../theme/theme_provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/button_styles.dart';
import '../theme/spacing.dart';
import '../widgets/dropdown_time_adjuster.dart';
import '../widgets/font_button.dart';
import '../widgets/color_button.dart';
import '../widgets/hoverable_button.dart';
import '../widgets/hoverable_icon.dart';

class SettingsScreen extends ConsumerWidget {
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final Function(Color) onColorChanged;
  final Function(String) onFontChanged;

  SettingsScreen({
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.onColorChanged,
    required this.onFontChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = Theme.of(context);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final buttonTextColor = themeNotifier.currentColor == Color(0xFF70F3F8)
        ? Color(0xFF1E213F)
        : Colors.white;

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: isMobile
            ? BorderRadius.circular(16.0)
            : BorderRadius.circular(24.0),
      ),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: isMobile ? 549 : 464,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
                constraints: BoxConstraints(
                  minWidth: isMobile ? 327 : 540,
                  maxWidth: isMobile ? 335 : 540,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: isMobile
                              ? EdgeInsets.symmetric(
                                  horizontal: AppSpacing.smedium,
                                  vertical: AppSpacing.medium)
                              : EdgeInsets.all(AppSpacing.medium),
                          child: Text(
                            'Settings',
                            style:
                                currentTheme.textTheme.headlineLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile
                                  ? 20
                                  : currentTheme
                                      .textTheme.headlineLarge!.fontSize,
                            ),
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
                    if (isMobile)
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.medium),
                        child: Center(
                          child: Text(
                            'TIME (MINUTES)',
                            style:
                                currentTheme.textTheme.headlineSmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile
                                  ? 11
                                  : currentTheme
                                      .textTheme.headlineSmall!.fontSize,
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.large),
                        child: Text(
                          'TIME (MINUTES)',
                          style: currentTheme.textTheme.headlineSmall!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile
                                ? 11
                                : currentTheme
                                    .textTheme.headlineSmall!.fontSize,
                          ),
                        ),
                      ),
                    if (isMobile)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: isMobile ? 0 : 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'pomodoro',
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                DropdownTimeAdjuster(
                                  label: 'pomodoro',
                                  value: pomodoroDuration,
                                  onChanged:
                                      timerNotifier.updatePomodoroDuration,
                                  isMobile: isMobile,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'short break',
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                DropdownTimeAdjuster(
                                  label: 'short break',
                                  value: shortBreakDuration,
                                  onChanged:
                                      timerNotifier.updateShortBreakDuration,
                                  isMobile: isMobile,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: isMobile ? 0 : 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'long break',
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                DropdownTimeAdjuster(
                                  label: 'long break',
                                  value: longBreakDuration,
                                  onChanged:
                                      timerNotifier.updateLongBreakDuration,
                                  isMobile: isMobile,
                                ),
                              ],
                            ),
                          ),
                          isMobile ? SizedBox(height: 8) : SizedBox(height: 0),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'pomodoro',
                                style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                child: DropdownTimeAdjuster(
                                    label: 'pomodoro',
                                    value: pomodoroDuration,
                                    onChanged:
                                        timerNotifier.updatePomodoroDuration),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'short break',
                                style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                child: DropdownTimeAdjuster(
                                    label: 'short break',
                                    value: shortBreakDuration,
                                    onChanged:
                                        timerNotifier.updateShortBreakDuration),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'long break',
                                style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                child: DropdownTimeAdjuster(
                                    label: 'long break',
                                    value: longBreakDuration,
                                    onChanged:
                                        timerNotifier.updateLongBreakDuration),
                              ),
                            ],
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
                        horizontal: AppSpacing.large,
                      ),
                      child: isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'FONT',
                                  style: currentTheme.textTheme.headlineSmall!
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile
                                        ? 11
                                        : currentTheme
                                            .textTheme.headlineSmall!.fontSize,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'KumbhSans',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'KumbhSans',
                                        onTap: () => onFontChanged('KumbhSans'),
                                        isMobile: isMobile,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'RobotoSlab',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'RobotoSlab',
                                        onTap: () =>
                                            onFontChanged('RobotoSlab'),
                                        isMobile: isMobile,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'SpaceMono',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'SpaceMono',
                                        onTap: () => onFontChanged('SpaceMono'),
                                        isMobile: isMobile,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'FONT',
                                  style: currentTheme.textTheme.headlineSmall!
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile
                                        ? 11
                                        : currentTheme
                                            .textTheme.headlineSmall!.fontSize,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'KumbhSans',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'KumbhSans',
                                        onTap: () => onFontChanged('KumbhSans'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'RobotoSlab',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'RobotoSlab',
                                        onTap: () =>
                                            onFontChanged('RobotoSlab'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: FontButton(
                                        context: context,
                                        fontFamily: 'SpaceMono',
                                        isSelected: currentTheme.textTheme
                                                .bodyLarge!.fontFamily ==
                                            'SpaceMono',
                                        onTap: () => onFontChanged('SpaceMono'),
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
                        vertical: AppSpacing.smedium,
                        horizontal: AppSpacing.large,
                      ),
                      child: isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'COLOR',
                                  style: currentTheme.textTheme.headlineSmall!
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile
                                        ? 11
                                        : currentTheme
                                            .textTheme.headlineSmall!.fontSize,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFFF87070),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFFF87070),
                                        themeNotifier: themeNotifier,
                                        isMobile: isMobile,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFF70F3F8),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFF70F3F8),
                                        themeNotifier: themeNotifier,
                                        isMobile: isMobile,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFFD881F8),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFFD881F8),
                                        themeNotifier: themeNotifier,
                                        isMobile: isMobile,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'COLOR',
                                  style: currentTheme.textTheme.headlineSmall!
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile
                                        ? 11
                                        : currentTheme
                                            .textTheme.headlineSmall!.fontSize,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFFF87070),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFFF87070),
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFF70F3F8),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFF70F3F8),
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColorButton(
                                        context: context,
                                        color: const Color(0xFFD881F8),
                                        isSelected: currentTheme
                                                .colorScheme.secondary ==
                                            const Color(0xFFD881F8),
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 35),
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
}
