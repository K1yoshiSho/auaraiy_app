import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/services/util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainInformation extends StatelessWidget {
  final String iconCode;
  final String tempValue;
  final String description;
  const MainInformation({
    Key? key,
    required this.tempValue,
    required this.description,
    required this.iconCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: getIconLink(iconCode),
          placeholder: (context, url) {
            return SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ));
          },
          width: 150,
          height: 150,
          color: getIconColor(iconCode, false, context),
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: SelectionArea(
              child: AutoSizeText(
            tempValue,
            maxLines: 1,
            style: AppTheme.of(context).bodyText1.override(
                  color: Colors.white,
                  fontSize: 70,
                ),
          )),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: SelectionArea(
              child: AutoSizeText(
            description,
            maxLines: 1,
            style: AppTheme.of(context).bodyText1.override(
                  color: Color(0xCBFFFFFF),
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
          )),
        ),
      ],
    );
  }
}

class MoreInformation extends StatelessWidget {
  final String weekValue;
  const MoreInformation({
    Key? key,
    required this.weekValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AutoSizeText(
            'Сегодня',
            textAlign: TextAlign.end,
            style: AppTheme.of(context).bodyText1.override(
                  color: Color(0xCBFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          flex: 2,
          child: AutoSizeText(
            '•',
            textAlign: TextAlign.center,
            style: AppTheme.of(context).bodyText1.override(
                  color: Color(0xCBFFFFFF),
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  weekValue,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: AppTheme.of(context).bodyText1.override(
                        color: Color(0xCBFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
