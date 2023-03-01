import 'package:auaraiy/common/components/loading_indicator.dart';
import 'package:auaraiy/common/constants/device_size.dart';
import 'package:auaraiy/common/constants/theme.dart';
import 'package:auaraiy/features/home_page/model/home_screen_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NotFoundComponent extends StatelessWidget {
  const NotFoundComponent({
    Key? key,
    required HomeScreenModel homeModel,
  })  : _homeModel = homeModel,
        super(key: key);

  final HomeScreenModel _homeModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: deviceSize.width * 0.7,
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
              "Не удалось найти город под названием: ${_homeModel.weatherProvider.searchText}\nПроверьте правильность написания или попробуйте ввести другой город.",
              style: AppTheme.of(context).bodyText1.copyWith(color: Color.fromARGB(255, 104, 104, 255)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
