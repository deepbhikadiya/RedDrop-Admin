

import 'package:web_redrop/package/config_packages.dart';

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}



CachedNetworkImage getImageView(
    {required String finalUrl,
    double height = 40,
    double width = 40,
    fit = BoxFit.none,
    Decoration? shape,
    Color? color}) {
  return CachedNetworkImage(
    imageUrl: finalUrl,
    fit: fit,
    height: height,
    width: width,
    placeholder: (context, url) => Container(
      margin: const EdgeInsets.all(10),
      height: height,
      width: width,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColor.primaryBlue,
        ),
      ),
    ),
    errorWidget: (context, url, error) => SizedBox(
      height: height,
      width: width,
      child: const Icon(Icons.error),
    ),
  );
}

class Throttler {
  Throttler({required this.throttleGapInMillis});

  final int throttleGapInMillis;
  int? lastActionTime;

  void run(VoidCallback action) {
    if (lastActionTime == null) {
      action();
      lastActionTime = DateTime.now().millisecondsSinceEpoch;
    } else {
      if (DateTime.now().millisecondsSinceEpoch - lastActionTime! >
          (throttleGapInMillis)) {
        action();
        lastActionTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }
}
