import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFFE9E0D6);
  static const Color white = Color(0xFFffffff);
  static const Color black = Color(0xFF000000);

  static const Color toastBackgroundColor = Color(0xFF090808);
  static const Color toastTextColor = Color(0xFFFFFEFE);
  static const Color colorButton = Color(0xFF28201A);
  static const Color colorCheckbox = Color(0xFF3564DB);
  static const Color borderError = Color(0xFFF23E3E);
  static const Color colorTitleHome = Color(0xFF7A5B44);
  static const Color colorAddressBook = Color(0xFFB75CFF);
  static const Color colorSetting = Color(0xFFFF975C);
  static const Color colorFeedback = Color(0xFF4AA56E);
  static const Color colorSupport = Color(0xFF1790FF);
  static const Color colorHelp = Color(0xFFFF4444);
  static  Color colorBgProfile = const Color(0xFFEFF0F8);
  static const Color lineColor = Color(0xFFDBDBDB);
  static const Color colorBanner = Color(0xFFFFF7EF);
  static const Color description = Color(0xFFC1C1C7);
  static const Color textGray = Color(0xFF8D8D8D);
  static const Color colorCheckBox = Color(0xFF2DEA40);
  static const Color colorEdit = Color(0xFF5E5E5E);


  static LinearGradient get getGradientPrimary {
    return _linearLR(
        [const Color(0xFF28201A).withOpacity(0.79), const Color(0xFF7A5B44).withOpacity(0.81)]);
  }

  static LinearGradient _linearLR(List<Color> colors) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
      );

}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    Color color = Colors.black;
    try {
      color = Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {}
    return color;
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
