import 'package:web_redrop/package/config_packages.dart';

typedef OnValidation = dynamic Function(String? text);


class AuthTextField extends StatefulWidget {
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
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:Responsive.isDesktop(context)? widget.width ?? MediaQuery.of(context).size.width/2.5: widget.width ?? double.infinity,
      child: TextFormField(
        style: const TextStyle().normal14w400.textColor(AppColor.black),
        autofillHints: widget.autofillHints,
        autocorrect: true,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        cursorColor: AppColor.black,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText!,

        maxLines: widget.maxLine,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.keyboardType ?? TextInputType.name,
        onChanged: (val) {
          if (widget.onChange != null) {
            widget.onChange!(val);
          }
        },

        validator: (val) {
          if (widget.validator != null) {
            return widget.validator!(val);
          } else {
            return null;
          }
        },
        enabled: widget.enable ?? true,
        cursorHeight: 12,
        decoration: InputDecoration(
          fillColor:widget.textFilledColor?? AppColor.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          counter: const Text(""),
          isDense: true,
          focusedErrorBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:widget.textFilledBorderColor?? AppColor.authFieldBorder,width: 1),

            borderRadius: BorderRadius.circular(widget.borderRadius??30.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:widget.textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius??30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:widget.textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius??30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:   BorderSide(color:widget.textFilledBorderColor?? AppColor.authFieldBorder,width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius??30.0),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          hintStyle: const TextStyle().normal14w400.textColor(AppColor.textFieldBorder),
        ),
      ),
    );
  }
}
