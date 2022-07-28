import 'package:flutter/material.dart';

import 'package:expenses_planner/material_you/material_you_palette.dart';

typedef LightColorScheme = ColorScheme;
typedef DarkColorScheme = ColorScheme;

typedef MaterialYouWidgetBuilder = Widget Function(
  BuildContext context,
  LightColorScheme lightColorScheme,
  DarkColorScheme darkColorscheme,
);

typedef MaterialYouWidgetErrorBuilder = Widget Function(
  BuildContext context,
  LightColorScheme lightColorScheme,
  DarkColorScheme darkColorscheme,
  Object? error,
);

class MaterialYouBuilder extends StatefulWidget {
  /// The default [ColorScheme].
  final ColorScheme colorScheme;

  /// Optional. Default dark [ColorScheme]. [colorScheme] is used when
  /// [darkColorScheme] is null.
  final ColorScheme? darkColorScheme;

  final MaterialYouWidgetBuilder builder;

  final bool applyDynamicColors;

  final bool _hasDarkTheme;

  final MaterialYouWidgetErrorBuilder? errorBuilder;
  const MaterialYouBuilder({
    required this.colorScheme,
    this.darkColorScheme,
    required this.builder,
    this.errorBuilder,
    this.applyDynamicColors = true,
    Key? key,
  })  : _hasDarkTheme = !(darkColorScheme == null),
        super(key: key);

  @override
  State<MaterialYouBuilder> createState() => _MaterialYouBuilderState();
}

class _MaterialYouBuilderState extends State<MaterialYouBuilder> {
  ColorScheme? lightMaterialYouColors;
  ColorScheme? darkMaterialYouColors;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: loadMaterialYouColors(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          if (widget.errorBuilder != null) {
            return widget.errorBuilder!(
              context,
              widget.applyDynamicColors
                  ? lightMaterialYouColors ?? widget.colorScheme
                  : widget.colorScheme,
              widget.applyDynamicColors
                  ? widget._hasDarkTheme
                      ? darkMaterialYouColors ?? widget.darkColorScheme!
                      : lightMaterialYouColors ?? widget.colorScheme
                  : widget.darkColorScheme ?? widget.colorScheme,
              snapshot.error,
            );
          }
        }

        return widget.builder(
          context,
          widget.applyDynamicColors
              ? lightMaterialYouColors ?? widget.colorScheme
              : widget.colorScheme,
          widget.applyDynamicColors
              ? widget._hasDarkTheme
                  ? darkMaterialYouColors ?? widget.darkColorScheme!
                  : lightMaterialYouColors ?? widget.colorScheme
              : widget.darkColorScheme ?? widget.colorScheme,
        );
      },
    );
  }

  Future<bool> loadMaterialYouColors() async {
    if (!widget.applyDynamicColors) return false;

    MaterialYouPalette? system = await getMaterialYouColors();
    if (system == null) return false;

    lightMaterialYouColors = schemeFromPalette(system, Brightness.light);
    darkMaterialYouColors = schemeFromPalette(system, Brightness.dark);
    return true;
  }
}
