import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialYouColor extends MaterialColor {
  const MaterialYouColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);
  Color get shade0 => this[0]!;
  Color get shade10 => this[10]!;
  Color get shade1000 => this[100]!;
}

class MaterialYou {
  static const MethodChannel _channel = MethodChannel('material_you_colors');

  static Future<Map<Object?, Object?>?> getMaterialYouColors() async {
    return await _channel.invokeMethod('getMaterialYouColors');
  }
}

Future<MaterialYouPalette?> getMaterialYouColors() async {
  // Material You colors are available on Android only
  if (defaultTargetPlatform != TargetPlatform.android) return null;

  try {
    final datam = await MaterialYou.getMaterialYouColors();
    if (datam == null) return null;
    var data =
        datam.map((key, value) => MapEntry(key as String, value as String));

    return MaterialYouPalette(
      accent1: data.getAccent1(),
      accent2: data.getAccent2(),
      accent3: data.getAccent3(),
      neutral1: data.getNeutral1(),
      neutral2: data.getNeutral2(),
    );
  } on PlatformException catch (_) {
    return null;
  }
}

class MaterialYouPalette {
  final MaterialYouColor accent1;
  final MaterialYouColor accent2;
  final MaterialYouColor accent3;
  final MaterialYouColor neutral1;
  final MaterialYouColor neutral2;

  MaterialYouPalette({
    required this.accent1,
    required this.accent2,
    required this.accent3,
    required this.neutral1,
    required this.neutral2,
  });
}

int _parseHexString(String value) => int.parse(value, radix: 16);

extension _ColorExtractionExtension on Map<String, dynamic> {
  Color getColor(String colorName) {
    final value = this[colorName];
    final parsed = _parseHexString(value);
    return Color(parsed);
  }

  MaterialYouColor getColours(String prefix) {
    return MaterialYouColor(
      _parseHexString(this['${prefix}_100']),
      <int, Color>{
        0: getColor('${prefix}_0'),
        10: getColor('${prefix}_10'),
        50: getColor('${prefix}_50'),
        100: getColor('${prefix}_100'),
        200: getColor('${prefix}_200'),
        300: getColor('${prefix}_300'),
        400: getColor('${prefix}_400'),
        500: getColor('${prefix}_500'),
        600: getColor('${prefix}_600'),
        700: getColor('${prefix}_700'),
        800: getColor('${prefix}_800'),
        900: getColor('${prefix}_900'),
        1000: getColor('${prefix}_1000'),
      },
    );
  }

  MaterialYouColor getAccent1() {
    return getColours('system_accent1');
  }

  MaterialYouColor getAccent2() {
    return getColours('system_accent2');
  }

  MaterialYouColor getAccent3() {
    return getColours('system_accent3');
  }

  MaterialYouColor getNeutral1() {
    return getColours('system_neutral1');
  }

  MaterialYouColor getNeutral2() {
    return getColours('system_neutral2');
  }
}

ColorScheme schemeFromPalette(
    MaterialYouPalette system, Brightness brightness) {
  if (brightness == Brightness.light) {
    return ColorScheme(
      brightness: Brightness.light,
      primary: system.accent1.shade600,
      onPrimary: system.accent1.shade0,
      primaryContainer: system.accent1.shade100,
      onPrimaryContainer: system.accent1.shade900,
      inversePrimary: system.accent1.shade200,
      secondary: system.accent2.shade600,
      onSecondary: system.accent2.shade0,
      secondaryContainer: system.accent2.shade100,
      onSecondaryContainer: system.accent2.shade900,
      tertiary: system.accent3.shade600,
      onTertiary: system.accent3.shade0,
      tertiaryContainer: system.accent3.shade100,
      onTertiaryContainer: system.accent3.shade900,
      error: const Color(0xffb3261e),
      onError: Colors.white,
      errorContainer: const Color(0xfff9dedc),
      onErrorContainer: const Color(0xff410e0b),
      outline: system.neutral2.shade500,
      background: system.neutral1.shade10,
      onBackground: system.neutral1.shade900,
      surface: system.neutral1.shade10,
      onSurface: system.neutral1.shade900,
      surfaceVariant: system.neutral2.shade100,
      onSurfaceVariant: system.neutral2.shade700,
      inverseSurface: system.neutral1.shade800,
      onInverseSurface: system.neutral1.shade50,
    );
  } else {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: system.accent1.shade200,
      onPrimary: system.accent1.shade800,
      primaryContainer: system.accent1.shade700,
      onPrimaryContainer: system.accent1.shade100,
      inversePrimary: system.accent1.shade600,
      secondary: system.accent2.shade200,
      onSecondary: system.accent2.shade800,
      secondaryContainer: system.accent2.shade700,
      onSecondaryContainer: system.accent2.shade100,
      tertiary: system.accent3.shade200,
      onTertiary: system.accent3.shade800,
      tertiaryContainer: system.accent3.shade700,
      onTertiaryContainer: system.accent3.shade100,
      error: const Color(0xfff2b8b5),
      onError: const Color(0xff601410),
      errorContainer: const Color(0xff8c1d18),
      onErrorContainer: const Color(0xfff2b8b5),
      outline: system.neutral2.shade400,
      background: system.neutral1.shade900,
      onBackground: system.neutral1.shade100,
      surface: system.neutral1.shade900,
      onSurface: system.neutral1.shade100,
      surfaceVariant: system.neutral2.shade700,
      onSurfaceVariant: system.neutral2.shade200,
      inverseSurface: system.neutral1.shade100,
      onInverseSurface: system.neutral1.shade800,
    );
  }
}
