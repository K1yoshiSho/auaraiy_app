import 'package:auaraiy/common/constants/theme.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor(BuildContext context) => AppTheme.of(context).primaryColor;
  static Color secondaryColor(BuildContext context) => AppTheme.of(context).secondaryColor;
  static Color dangerColor(BuildContext context) => AppTheme.of(context).dangerColor;
  static Color primaryBackground(BuildContext context) => AppTheme.of(context).primaryBackground;
  static Color secondaryBackground(BuildContext context) => AppTheme.of(context).secondaryBackground;
  static Color primaryText(BuildContext context) => AppTheme.of(context).primaryText;
  static Color secondaryText(BuildContext context) => AppTheme.of(context).secondaryText;
  static Color primaryBtnText(BuildContext context) => AppTheme.of(context).primaryBtnText;
  static Color darkColor = Color(0xff48484a);
  static Color iconColor(BuildContext context) => AppTheme.of(context).iconColor;
}
