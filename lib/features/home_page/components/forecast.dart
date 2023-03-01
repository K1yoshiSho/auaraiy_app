import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/services/util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class ForecastList extends StatelessWidget {
  final List<Weather> forecastList;
  const ForecastList({
    Key? key,
    required this.forecastList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1, 0.85),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AutoSizeText(
                    'Прогноз на 5 дней',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: AppTheme.of(context).bodyText1.override(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: forecastList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: (index == 0) ? 12 : 4, right: (index == forecastList.length - 1) ? 12 : 4),
                      child: ForecastCard(
                        date: forecastList[index].date!,
                        description: forecastList[index].weatherDescription!,
                        temp: "${forecastList[index].temperature?.celsius?.toStringAsFixed(0).capitalize()}°",
                        iconCode: forecastList[index].weatherIcon!,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  final DateTime date;
  final String description;
  final String temp;
  final String iconCode;
  const ForecastCard({
    Key? key,
    required this.date,
    required this.description,
    required this.temp,
    required this.iconCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              DateFormat('E, d MMM', 'ru').format(date).capitalize(),
              maxLines: 1,
              style: AppTheme.of(context).bodyText1,
            ),
            AutoSizeText(
              DateFormat('H:mm', 'ru').format(date).capitalize(),
              maxLines: 1,
              style: AppTheme.of(context).bodyText1,
            ),
            CachedNetworkImage(
                imageUrl: getIconLink(iconCode),
                placeholder: (context, url) {
                  return SizedBox(
                      width: 40,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ));
                },
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                color: getIconColor(iconCode, true, context)),
            // Image.network(
            //   getIconLink(iconCode),
            //   width: 60,
            //   height: 60,
            //   fit: BoxFit.cover,
            //   color: getIconColor(iconCode, true, context),
            // ),
            AutoSizeText(
              temp,
              maxLines: 1,
              style: AppTheme.of(context).bodyText1,
            ),
            AutoSizeText(
              description,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTheme.of(context).bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
