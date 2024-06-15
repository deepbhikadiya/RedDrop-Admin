import 'package:web_redrop/package/config_packages.dart';

void showAppToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showErrorToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: AppColor.primaryRed,
    textColor: AppColor.white,
    fontSize: 14,
    gravity: ToastGravity.BOTTOM,
  );
}

