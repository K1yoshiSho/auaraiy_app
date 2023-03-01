import 'package:auaraiy/common/components/loading_indicator.dart';
import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/common/services/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NotFoundComponent extends StatelessWidget {
  const NotFoundComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: RiveAnimation.asset('assets/rive/404_v1 (2).riv',
                  placeHolder: LoadingIndicator(),
                  controllers: [SimpleAnimation('Idle')],
                  fit: BoxFit.contain,
                  alignment: Alignment.center),
            ),
            AutoSizeText(
              "Не удалось найти город под названием: ${sharedPreference.getSearchText}\nПроверьте правильность написания или попробуйте ввести другой город.",
              style: AppTheme.of(context).bodyText1.copyWith(color: Color.fromARGB(255, 104, 104, 255)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
