import 'package:auaraiy/common/components/loading_indicator.dart';
import 'package:auaraiy/common/constants/app_colors.dart';
import 'package:auaraiy/common/constants/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NoConnectionComponent extends StatelessWidget {
  const NoConnectionComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: RiveAnimation.asset('assets/rive/new_connection_states (1).riv',
                  placeHolder: LoadingIndicator(),
                  controllers: [SimpleAnimation('Connecting')],
                  fit: BoxFit.contain,
                  alignment: Alignment.center),
            ),
            AutoSizeText(
              "Нет соединия с интернетом, убедитесь что вы подключены к сети",
              style: AppTheme.of(context).bodyText1.copyWith(color: AppColors.dangerColor(context)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
