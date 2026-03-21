// ignore_for_file: constant_identifier_names

import '../imports/imports.dart';

const String KUser = 'user';
const String KUserToken = 'user_token';
const String KUserLanguage = 'user_language';
const String KOnboardingCompleted = 'onboarding_completed';
const String KIsLight = 'is_light_mode';
const String KFcmTokenKey = 'fcm_token';
const String KNotificationChannelKey = 'basic_channel';

PhoneController initialPhoneController() => PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.SY, nsn: ''),
    );

const int KPageSize = 10;
const int KPageNumber = 1;
