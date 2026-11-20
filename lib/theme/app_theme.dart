import 'package:material_ui/material_ui.dart';

class AppTheme {
  const AppTheme._();

  static const Color navy = Color(0xFF17365D);
  static const Color ink = Color(0xFF19324D);
  static const Color mutedInk = Color(0xFF64788F);
  static const Color background = Color(0xFFF4F7FB);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFD8E1EC);
  static const Color amber = Color(0xFFD8A12F);
  static const Color warning = Color(0xFFAD6A00);
  static const Color critical = Color(0xFFC43D3D);
  static const Color success = Color(0xFF2E7D32);

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: navy,
      primary: navy,
      surface: surface,
    ),
    scaffoldBackgroundColor: background,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.45,
        color: ink,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        height: 1.35,
        color: mutedInk,
      ),
    ),
  );
}
