import 'package:web_redrop/package/config_packages.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.textEditingController,
      this.hintText,
        this.suffixIcon,
      this.onChanged,
      this.onFieldSubmitted});

  final TextEditingController textEditingController;
  final String? hintText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      controller: textEditingController,
      style: const TextStyle().normal14w500.textColor(AppColor.black),
      cursorColor: AppColor.black,
      decoration: InputDecoration(
        hoverColor: AppColor.white,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        hintText: hintText,
        suffixIcon:suffixIcon,
        hintStyle:
            const TextStyle().normal14w500.textColor(AppColor.primaryBlue),
        fillColor: AppColor.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(97),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(97),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(97),
        ),

      ),
    );
  }
}
