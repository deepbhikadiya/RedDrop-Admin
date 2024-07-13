import 'package:web_redrop/package/config_packages.dart';

class CommonContainerDecoration {
  static boxDecoration({double? borderRadius, Color? color}) {
    return BoxDecoration(
      color: color ?? AppColor.white,
      borderRadius: BorderRadius.circular(borderRadius ?? 35),
      border: Border.all(
        width: 1,
        color: AppColor.black.withOpacity(
          0.1,
        ),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 11,
          offset: const Offset(0, 5),
          color: AppColor.shadowColor.withOpacity(.01),
        ),
        BoxShadow(
          blurRadius: 20,
          offset: const Offset(0, 20),
          color: AppColor.shadowColor.withOpacity(.09),
        ),
        BoxShadow(
          blurRadius: 28,
          offset: const Offset(0, 46),
          color: AppColor.shadowColor.withOpacity(.05),
        ),
        BoxShadow(
          blurRadius: 33,
          offset: const Offset(0, 82),
          color: AppColor.shadowColor.withOpacity(.01),
        ),
        BoxShadow(
          blurRadius: 36,
          offset: const Offset(0, 128),
          color: AppColor.shadowColor.withOpacity(0),
        ),
      ],
    );
  }
}
