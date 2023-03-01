import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_windows/local_auth_windows.dart';

class HomeRepository {
  void checkBiometric(bool _biometricValue) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final _localAuth = LocalAuthentication();
      bool _isBiometricSupported = await _localAuth.isDeviceSupported();
      if (_isBiometricSupported) {
        _biometricValue = await _localAuth.authenticate(
            localizedReason: 'Подтвердите личность чтобы зайти в приложение :D',
            options: AuthenticationOptions(),
            authMessages: [
              IOSAuthMessages(
                  cancelButton: 'Отмена',
                  goToSettingsButton: 'Настройки',
                  goToSettingsDescription: 'Пожалуйста, настройте биометрию.',
                  lockOut: 'Блокировка',
                  localizedFallbackTitle: "Подтвердите личность"),
              AndroidAuthMessages(
                  cancelButton: 'Отмена',
                  goToSettingsButton: 'Настройки',
                  goToSettingsDescription: 'Пожалуйста, настройте биометрию.',
                  signInTitle: 'Подтвердите личность',
                  biometricHint: 'Это важно :)',
                  deviceCredentialsRequiredTitle: 'Подтвердите личность',
                  deviceCredentialsSetupDescription: 'Требуется подтверждение'),
              WindowsAuthMessages()
            ]);
      }
      if (_biometricValue == false) exit(0);
    });
  }
}
