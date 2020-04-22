import 'dart:ui';

class AppColors {
  static const green = 0xff0BCE83;
  static const blue = 0xff7BBAEE;
  static const background = 0xffF6F5F5;
  static const font = 0xff2D0C57;
  static const font_inverse = 0xfffffff;
  static const font_light = 0xff9586A8;
  static const font_light_green = 0xff06BE77;

  getFontColor() {
    Color color = Color(0xff000000);
    color.withOpacity(0.8);
    return color;
  }
}
