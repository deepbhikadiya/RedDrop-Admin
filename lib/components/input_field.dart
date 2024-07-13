import 'package:web_redrop/package/config_packages.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool firstCapital;
  final bool disable;
  final bool readOnly;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isHasInVisibleBorder;
  final List<TextInputFormatter>? inputFormatter;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final double? width;
  final Color? textFieldColor;
  final TextStyle? hintStyle;
  final Color? borderColor;

  const InputField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly=false,
    this.focusNode,
    this.obscureText = false,
    this.disable = false,
    this.firstCapital = false,
    this.hint = "",
    this.onChange,
    this.inputFormatter,
    this.onSubmitted,
    this.onTap,
    this.isHasInVisibleBorder = false,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine,
    this.width,
    this.textFieldColor,
    this.hintStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    readOnly: readOnly,
      onTap: onTap ?? () {},
      textCapitalization:
          firstCapital ? TextCapitalization.words : TextCapitalization.none,
      cursorColor: AppColor.black,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      autofocus: false,
      obscureText: obscureText,
      maxLines: maxLine,
      inputFormatters: inputFormatter ?? [],
      style: const TextStyle().normal18w600,
      decoration: InputDecoration(
        suffix: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        prefixIcon: prefixIcon,
        hoverColor: AppColor.primaryBlue.withOpacity(0.1),
        isCollapsed: true,
        enabled: !disable,
        hintStyle: hintStyle ??
            const TextStyle(color: AppColor.secondaryColor).normal14w500,
        fillColor: textFieldColor ?? AppColor.white,
        hintText: hint,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: isHasInVisibleBorder == true
                ? Colors.transparent
                : borderColor ?? AppColor.primaryBlue,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: isHasInVisibleBorder == true
                ? Colors.transparent
                : borderColor ?? AppColor.primaryBlue,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: isHasInVisibleBorder == true
                ? Colors.transparent
                : borderColor ?? AppColor.primaryBlue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: isHasInVisibleBorder == true
                ? Colors.transparent
                : borderColor ?? AppColor.primaryBlue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: isHasInVisibleBorder == true
                ? Colors.transparent
                : borderColor ?? AppColor.primaryBlue,
          ),
        ),
        filled: true,
      ),
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.name,
      onChanged: (val) {
        if (onChange != null) {
          onChange!(val);
        }
      },
      onFieldSubmitted: onSubmitted,
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        } else {
          return null;
        }
      },
    );
  }
}
