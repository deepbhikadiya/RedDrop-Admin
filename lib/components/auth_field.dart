import 'package:web_redrop/package/config_packages.dart';

typedef OnValidation = dynamic Function(String? text);


class AuthTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? textFilledColor;
  final Color? textFilledBorderColor;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? obscureText;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? maxLength;
  final bool readOnly;
  final double? width;
  final double? borderRadius;
  final bool? enable;
  const AuthTextField(
      {Key? key,
        this.borderRadius,
        this.textFilledBorderColor,
        this.enable,
        this.onFieldSubmitted,
        this.prefixIcon,
        this.suffixIcon,
        this.maxLength,
        this.width,
        this.onTap,
        this.hintText = "",
        this.focusNode,
        this.controller,
        this.obscureText = false,
        this.readOnly = false,
        this.validator,
        this.onChange,
        this.textInputAction,
        this.keyboardType,
        this.maxLine,
        this.textFilledColor,
        this.autofillHints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 58,
      width:Responsive.isDesktop(context)? width ?? MediaQuery.of(context).size.width/2.5: width ?? double.infinity,
      child: TextFormField(
        style: const TextStyle().normal14w400.textColor(AppColor.black),
        autofillHints: autofillHints,
        autocorrect: true,
        onFieldSubmitted: onFieldSubmitted,
        readOnly: readOnly,
        onTap: onTap,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText!,

        maxLines: maxLine,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.name,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },

        validator: (val) {
          if (validator != null) {
            return validator!(val);
          } else {
            return null;
          }
        },
        enabled: enable ?? true,
        cursorHeight: 12,
        decoration: InputDecoration(
          fillColor:textFilledColor?? AppColor.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          counter: const Text(""),
          isDense: true,
          focusedErrorBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:textFilledBorderColor?? AppColor.authFieldBorder,width: 1),

            borderRadius: BorderRadius.circular(borderRadius??30.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(borderRadius??30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(borderRadius??30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(borderRadius??30.0),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle().normal14w400.textColor(AppColor.textFieldBorder),
        ),
      ),
    );
  }
}
