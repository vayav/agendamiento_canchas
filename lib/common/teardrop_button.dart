import 'package:flutter/material.dart';

import '../../common/values.dart';

enum TearDropAlignment { topLeft, topRight, bottomLeft, bottomRight }

class TearDropButton extends StatelessWidget {
  const TearDropButton({
    super.key,
    required this.buttonText,
    this.radius,
    this.tearDropAlignment = TearDropAlignment.topRight,
    this.buttonTextStyle,
    this.color = AppColors.orangeShade6,
    this.style = PaintingStyle.fill,
    this.onTap,
    this.elevation = Sizes.ELEVATION_8,
    this.hasShadow = false,
    this.shadowColor,
  });

  final double? radius;
  final Color? color;
  final TearDropAlignment tearDropAlignment;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final PaintingStyle style;
  final GestureTapCallback? onTap;
  final bool hasShadow;
  final double elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    double defaultRadius = assignHeight(context: context, fraction: 0.07);
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: SizedBox(
        height: (defaultRadius) * 2,
        width: (defaultRadius) * 2,
        child: Stack(
          children: [
            SizedBox(
              height: (defaultRadius) * 2,
              width: (defaultRadius) * 2,
              child: CustomPaint(
                painter: DrawTearDrop(
                  color: color!,
                  offset: Offset(
                    defaultRadius,
                    defaultRadius,
                  ),
                  elevation: elevation,
                  shadowColor: shadowColor,
                  hasShadow: hasShadow,
                  paintingStyle: style,
                  radius: defaultRadius,
                  tearDropAlignment: tearDropAlignment,
                ),
              ),
            ),
            SizedBox(
              height: (defaultRadius) * 2,
              width: (defaultRadius) * 2,
              child: Center(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: buttonTextStyle ??
                      theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum DisplayType {
  desktop,
  mobile,
}

const _desktopPortraitBreakpoint = 700.0;
const _desktopLandscapeBreakpoint = 1000.0;

/// Returns the [DisplayType] for the current screen. This app only supports
/// mobile and desktop layouts, and as such we only have one breakpoint.
DisplayType displayTypeOf(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;

  if ((orientation == Orientation.landscape &&
          width > _desktopLandscapeBreakpoint) ||
      (orientation == Orientation.portrait &&
          width > _desktopPortraitBreakpoint)) {
    return DisplayType.desktop;
  } else {
    return DisplayType.mobile;
  }
}

/// Returns a boolean if we are in a display of [DisplayType.desktop]. Used to
/// build adaptive and responsive layouts.
bool isDisplayDesktop(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

/// Returns a boolean if we are in a display of [DisplayType.desktop] but less
/// than [_desktopLandscapeBreakpoint] width. Used to build adaptive and responsive layouts.
bool isDisplaySmallDesktop(BuildContext context) {
  return isDisplayDesktop(context) &&
      MediaQuery.of(context).size.width < _desktopLandscapeBreakpoint;
}

double widthOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double assignHeight({
  required BuildContext context,
  required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (heightOfScreen(context) - (subs) + (additions)) * fraction;
}

double assignWidth({
  required BuildContext context,
  required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (widthOfScreen(context) - (subs) + (additions)) * fraction;
}
