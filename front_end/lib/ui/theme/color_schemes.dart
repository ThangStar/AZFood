import 'package:flutter/material.dart';

//: // is require

var colorScheme = (BuildContext context) => Theme.of(context).colorScheme;
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF3941F4),
  onPrimary: Color(0xFFFFFFFF), //text
  primaryContainer: Color(0xFFE0E0FF),
  onPrimaryContainer: Color(0xFF00006E),
  secondary: Color(0xFF6E85E3),//button
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE0E0FF),
  onSecondaryContainer: Color(0xFF00006E),
  tertiary: Color(0xFFD4D4D8), //gray
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E3),
  onTertiaryContainer: Color(0xFF3E001E),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFBFF), //background
  onBackground: Color(0xFF001B3D),
  surface: Color(0xFFFDFBFF),
  onSurface: Color(0xFF001B3D),
  surfaceVariant: Color(0xFFE4E1EC),
  onSurfaceVariant: Color(0xFF46464F),
  outline: Color(0xFF777680),
  onInverseSurface: Color(0xFFECF0FF),
  inverseSurface: Color(0xFF003062),
  inversePrimary: Color(0xFFBFC2FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF3941F4),
  outlineVariant: Color(0xFFC7C5D0),
  scrim: Color(0xFF000000),//text
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFBFC2FF),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF161BDF),
  onPrimaryContainer: Color(0xFFE0E0FF),
  secondary: Color(0xFF0100AC),
  onSecondary: Color(0xFF0100AC),
  secondaryContainer: Color(0xFF161BDF),
  onSecondaryContainer: Color(0xFFE0E0FF),
  tertiary: Color(0xFF0100AC),
  onTertiary: Color(0xFF5E1134),
  tertiaryContainer: Color(0xFF7B294A),
  onTertiaryContainer: Color(0xFFFFD9E3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001B3D),
  onBackground: Color(0xFFD6E3FF),
  surface: Color(0xFF001B3D),
  onSurface: Color(0xFFD6E3FF),
  surfaceVariant: Color(0xFF46464F),
  onSurfaceVariant: Color(0xFFC7C5D0),
  outline: Color(0xFF918F9A),
  onInverseSurface: Color(0xFF001B3D),
  inverseSurface: Color(0xFFD6E3FF),
  inversePrimary: Color(0xFF3941F4),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFBFC2FF),
  outlineVariant: Color(0xFF46464F),
  scrim: Color(0xFFFFFFFF),
);
