import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.onPressed,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;

  @override
  void initState() {
    final isFontAwesome = widget.icon is FaIcon;
    if (isFontAwesome) {
      final icon = widget.icon as FaIcon;
      iconSize = icon.size;
      iconColor = icon.color;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
        overlayColor: MaterialStateProperty.all(Color.fromARGB(62, 233, 233, 233)),
        splashColor: Theme.of(context).splashColor,
        // backgroundColor: MaterialStateProperty.all(Colors.transparent),
        child: (widget.showLoadingIndicator && loading)
            ? Center(
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      iconColor ?? Colors.white,
                    ),
                  ),
                ),
              )
            : IconButton(
                icon: widget.icon,
                onPressed: widget.onPressed == null
                    ? null
                    : () async {
                        if (loading) {
                          return;
                        }
                        setState(() => loading = true);
                        try {
                          await widget.onPressed!();
                        } finally {
                          if (mounted) {
                            setState(() => loading = false);
                          }
                        }
                      },
                splashRadius: widget.borderRadius,
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MaterialIconButton extends StatelessWidget {
  MaterialIconButton({
    Key? key,
    required this.context,
    required this.onPress,
    required this.width,
    required this.height,
    this.minWidth,
    this.elevation,
    this.highlightElevation,
    this.backgroundColor,
    this.borderColor,
    this.materialTapTargetSize,
    this.iconPadding,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  final BuildContext context;
  double width;
  double height;
  final VoidCallback onPress;
  double? minWidth;
  double? elevation;
  double? highlightElevation;
  Color? borderColor;
  Color? backgroundColor;
  MaterialTapTargetSize? materialTapTargetSize;
  EdgeInsetsGeometry? iconPadding;
  double? borderRadius;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
          onPressed: onPress,
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          highlightColor: Theme.of(context).splashColor,
          splashColor: Theme.of(context).splashColor,
          minWidth: minWidth ?? ScreenUtil().setSp(90),
          highlightElevation: highlightElevation ?? 1,
          elevation: elevation ?? 0,
          materialTapTargetSize: materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
          padding: iconPadding ??
              EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(25),
                vertical: ScreenUtil().setSp(25),
              ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(borderRadius ?? 22)),
          ),
          child: child),
    );
  }
}

class AppIconButton extends StatefulWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.onPressed,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;

  @override
  void initState() {
    final isFontAwesome = widget.icon is FaIcon;
    final isIcon = widget.icon is Icon;
    if (isFontAwesome) {
      final icon = widget.icon as FaIcon;
      iconSize = icon.size;
      iconColor = icon.color;
    } else if (isIcon) {
      final icon = widget.icon as Icon;
      iconSize = icon.size;
      iconColor = icon.color;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: widget.buttonSize,
        height: widget.buttonSize,
        decoration: BoxDecoration(
          color: widget.onPressed != null ? widget.fillColor : widget.disabledColor,
          border: Border.all(
            color: widget.borderColor ?? Colors.transparent,
            width: widget.borderWidth ?? 0,
          ),
          borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null,
        ),
        child: (widget.showLoadingIndicator && loading)
            ? Center(
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      iconColor ?? Colors.white,
                    ),
                  ),
                ),
              )
            : InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: widget.buttonSize,
                    child: widget.icon,
                  ),
                ),
                onTap: widget.onPressed,
              ),
        // : IconButton(
        //     icon: widget.icon,
        //     onPressed: widget.onPressed == null
        //         ? null
        //         : () async {
        //             if (loading) {
        //               return;
        //             }
        //             setState(() => loading = true);
        //             try {
        //               await widget.onPressed!();
        //             } finally {
        //               if (mounted) {
        //                 setState(() => loading = false);
        //               }
        //             }
        //           },
        //     splashRadius: 5,
        //   ),
      ),
    );
  }
}
