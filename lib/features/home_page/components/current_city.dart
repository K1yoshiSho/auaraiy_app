import 'package:auaraiy/common/constants/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CurrentCity extends StatelessWidget {
  final String cityName;
  const CurrentCity({
    Key? key,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0.1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: Icon(
              Icons.location_on,
              color: Color(0xCBFFFFFF),
              size: 30,
            ),
          ),
          AutoSizeText(
            cityName,
            style: AppTheme.of(context).bodyText1.override(
                  color: Color(0xCBFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
