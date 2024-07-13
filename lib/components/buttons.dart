import 'package:web_redrop/package/config_packages.dart';


class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;
  final bool? isBorder;
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isAddButton;
  final Color? buttonColor;
  final Color? disableButtonColor;

  const CommonAppButton({
    Key? key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    this.text,
    this.color,
    this.icon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.isBorder = false,
    this.width,
    this.boxShadow,
    this.border,
    this.isAddButton,
    this.buttonColor,
    this.disableButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = disableButtonColor ?? AppColor.fillColor;
    switch (buttonType) {
      case ButtonType.enable:
        {
          if (isAddButton == true) {
            background = buttonColor!;
          } else {
            background = AppColor.primaryRed;
          }
        }
        break;
      case ButtonType.disable:
        {
          background = disableButtonColor ?? AppColor.fillColor;
        }
        break;
      case ButtonType.progress:
        background = AppColor.primaryRed;
        break;
    }
    return Material(
      color: isBorder == true ? null : background,
      borderRadius: BorderRadius.circular(borderRadius ?? 69),
      child: InkWell(
        hoverColor: (buttonType == ButtonType.enable)
            ? buttonColor ?? AppColor.primaryRed
            : AppColor.fillColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 69),
        onTap: (buttonType == ButtonType.enable) ? (onTap ?? () {}) : () {},
        child: Container(
          height: height ?? 55,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: isBorder == true ? Colors.white : Colors.transparent,
            border: isBorder == true
                ? Border.all(width: 1.5, color: AppColor.primaryRed)
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 69),
            boxShadow: boxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonType == ButtonType.progress)
                const CircularProgressIndicator(color: AppColor.white,),
              if (buttonType != ButtonType.progress)
                Center(
                  child: Text(
                    text!,
                    style: style ??
                        const TextStyle().normal18w700.textColor(
                            isBorder == true
                                ? AppColor.primaryRed
                                : AppColor.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
