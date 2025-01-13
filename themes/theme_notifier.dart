import 'package:flutter/material.dart';

/// Custom Theme Extension to define additional theme properties.
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? text2Color;
  final Color? iconColor;
  final Color? icon2Color;
  final Color? selectionColor;
  final Color? hintColor;
  final Color? titleColor;
  final Color? borderColor;
  final Color? tileColor;
  final Color? dividerColor;
  final Color? divider2Color;
  final Color? checkboxColor;
  final Color? checkColor;
  final Color? drawerColor;

  CustomThemeExtension({
    this.backgroundColor,
    this.textColor,
    this.text2Color,
    this.iconColor,
    this.icon2Color,
    this.selectionColor,
    this.hintColor,
    this.titleColor,
    this.borderColor,
    this.tileColor,
    this.dividerColor,
    this.divider2Color,
    this.checkboxColor,
    this.checkColor,
    this.drawerColor,
  });

  @override
  CustomThemeExtension copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? text2Color,
    Color? iconColor,
    Color? icon2Color,
    Color? selectionColor,
    Color? hintColor,
    Color? titleColor,
    Color? borderColor,
    Color? tileColor,
    Color? dividerColor,
    Color? divider2Color,
    Color? checkboxColor,
    Color? checkColor,
    Color? drawerColor,
  }) {
    return CustomThemeExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      text2Color: text2Color ?? this.text2Color,
      iconColor: iconColor ?? this.iconColor,
      icon2Color: icon2Color ?? this.icon2Color,
      selectionColor: selectionColor ?? this.selectionColor,
      hintColor: hintColor ?? this.hintColor,
      titleColor: titleColor ?? this.titleColor,
      borderColor: borderColor ?? this.borderColor,
      tileColor: tileColor ?? this.tileColor,
      dividerColor: dividerColor ?? this.dividerColor,
      divider2Color: divider2Color ?? this.divider2Color,
      checkboxColor: checkboxColor ?? this.checkboxColor,
      checkColor: checkColor ?? this.checkColor,
      drawerColor: drawerColor ?? this.drawerColor,
    );
  }

  @override
  CustomThemeExtension lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      text2Color: Color.lerp(text2Color, other.text2Color, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      icon2Color: Color.lerp(icon2Color, other.icon2Color, t),
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t),
      hintColor: Color.lerp(hintColor, other.hintColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      tileColor: Color.lerp(tileColor, other.tileColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      divider2Color: Color.lerp(divider2Color, other.divider2Color, t),
      checkboxColor: Color.lerp(checkboxColor, other.checkboxColor, t),
      checkColor: Color.lerp(checkColor, other.checkColor, t),
      drawerColor: Color.lerp(drawerColor, other.drawerColor, t),
    );
  }
}

/// Light Theme
final ThemeData simpleNavy = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      backgroundColor: Color(0xFFDDF2FD),
      textColor: Color(0xFF000033),
      text2Color: Color(0xFFF8FAFC),
      iconColor: Color(0xFF000033),
      icon2Color: Color(0xFFF8FAFC),
      selectionColor: Color(0xFFD9EAFD),
      hintColor: Color(0xFF5C5C7A),
      titleColor: Color(0xFF000033),
      borderColor: Color(0xFF000033),
      tileColor: Color(0xFFF8FAFC),
      dividerColor: Color(0xFF000033),
      divider2Color: Color(0xFFF8FAFC),
      checkboxColor: Color(0xFF000033),
      checkColor: Color(0xFFF8FAFC),
      drawerColor: Color(0xFF000033),
    ),
  ],
);

final ThemeData brownGradient = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      backgroundColor: Color(0xFFF4F3EE),
      textColor: Color(0xFF463F3A),
      text2Color: Color(0xFFF4F3EE),
      iconColor: Color(0xFF463F3A),
      icon2Color: Color(0xFFF4F3EE),
      selectionColor: Color(0xFF8A817C),
      hintColor: Color(0xFF8A817C),
      titleColor: Color(0xFF463F3A),
      borderColor: Color(0xFF463F3A),
      tileColor: Color(0xFFBCB8B1),
      dividerColor: Color(0xFF463F3A),
      divider2Color: Color(0xFFF4F3EE),
      checkboxColor: Color(0xFF463F3A),
      checkColor: Color(0xFFF4F3EE),
      drawerColor: Color(0xFF463F3A),
    ),
  ],
);

/// Dark Theme
final ThemeData espresso = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      backgroundColor: Color(0xFFEDE0D4),
      textColor: Colors.white,
      text2Color: Colors.white,
      iconColor: Color(0xFF260701),
      icon2Color: Colors.white,
      selectionColor: Color(0xff8b7f73),
      hintColor: Color(0xff6c625a),
      titleColor: Color(0xFF260701),
      borderColor: Color(0xFF260701),
      tileColor: Color(0xFF4A2419),
      dividerColor: Color(0xFF260701),
      divider2Color: Colors.white,
      checkboxColor: Colors.white,
      checkColor: Color(0xFF4A2419),
      drawerColor: Color(0xFF260701),
    ),
  ],
);

final ThemeData pinkPerfection = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    CustomThemeExtension(
      backgroundColor: Color(0xFFff084a),
      textColor: Color(0xFF260701),
      text2Color: Color(0xFFfc3468),
      iconColor: Color(0xFFfff5ee),
      icon2Color: Color(0xFFfc3468),
      selectionColor: Color(0xFFF6D9D5),
      hintColor: Color(0xfff3c4cc) ,
      titleColor: Color(0xFFfff5ee),
      borderColor: Color(0xFF260701),
      tileColor:  Color(0xFFffc2cd),
      dividerColor: Color(0xFFfff5ee),
      divider2Color: Color(0xFFfc3468),
      checkboxColor: Color(0xFFF6D9D5),
      checkColor: Color(0xFF260701),
      drawerColor: Color(0xFFfffff2),
    ),
  ],
);

/// Theme Notifier for managing theme changes.
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  /// Switch theme to the given theme.
  void switchTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
