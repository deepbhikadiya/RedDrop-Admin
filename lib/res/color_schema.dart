import 'package:web_redrop/package/config_packages.dart';

abstract class AppColor {
  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      AppPref().isDark = true;
    }
  }

  const AppColor._();

  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static Color primaryColor() {
    return isDarkTheme() ? DarkTheme.primary : LightTheme.primary;
  }


  static const textFieldBorder = Color(0xFFE2E8F0);
  static const authFieldBorder = Color(0xFFEEEEEE);
  static const green = Color(0xFF16C098);
  static const primaryCream = Color(0xFFFFF3E6);
  static const primaryBlue = Color(0xFFDE0A1E);
  static const lightGreen = Color(0xFFD3FFE7);
  static const dividerColor = Color(0xFFEEEEEE);
  static const shadowColor = Color(0xffC2A07A);
  static const borderColor = Color(0xffE2CBB7);
  static const fillColor = Color(0xffFFF2E6);
  static const orange = Color(0xffFF8819);
  static const lightOrange = Color(0xffFFF3E8);
  static const purple = Color(0xff5D55BC);
  static const violet = Color(0xff844EA4);
  static const lightGrey = Color(0xffEDEDED);
  static const lightRed= Color(0xffFB5458);
  static const dataHeadingColor = Color(0xffFFF5EC);
  static const grey = Color(0xff838383);
  static const rowData = Color(0xffD9D9D9);
  static const paginationGray = Color(0xff656565);
  static const grayB8 = Color(0xffB8B8B8);
  static const grayB3 = Color(0xffB3B3B3);
  static const black = Color(0xFF000000);
  static const saveGreen = Color(0xFF61C36D);
  static const starYellow = Color(0xFFFFB400);
  static const dialogueGrayColor = Color(0xFFE4E4E4);
  static const whiteF7Color = Color(0xFFF7F7F7);


  ///======================== RedDrop ========================

  static const primaryRed = Color(0xFFDE0A1E);
  static const primaryDarkBlue = Color(0xff050A30);
  static const primarySkyBlue = Color(0xffEEFEFF);
  static const white = Color(0xFFFFFFFF);
  static const textColor = Color(0xFF353535);
  static const secondaryColor = Color(0xFFB6B6B6);
  static const secondaryTextColor = Color(0xFFE3E3E3);
  static const tabTextColor = Color(0xFF2C2C2C);

}

class LightTheme {
  static const primary = Color(0xff18191A);
}

class DarkTheme {
  static const primary = Color(0xff18191A);
}
