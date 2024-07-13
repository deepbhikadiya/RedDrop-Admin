import 'package:web_redrop/package/config_packages.dart';

class HeaderWidget extends StatelessWidget {
  final String headerText;

  const HeaderWidget({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40, top: 30, bottom: 30),
      child: SizedBox(
        height: 38,
        child: Row(
          children: [
            Text(
              headerText ,
              style: const TextStyle().normal30w700.textColor(AppColor.black),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
