import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import '../imports/imports.dart';
import 'app_local.dart';

// dart run generate_localization_keys.dart
class AppString {
  static final Localization _localization = Localization.instance;
  Future<void> loadTranslations() async {
    await EasyLocalizationController.initEasyLocation();
    final controller = EasyLocalizationController(
      saveLocale: true,
      fallbackLocale: AppLocale.fallbackLocale,
      supportedLocales: AppLocale.supportedLocales,
      assetLoader: const RootBundleAssetLoader(),
      useOnlyLangCode: false,
      useFallbackTranslations: true,
      path: AppLocale.path,
      onLoadError: (FlutterError e) {},
    );
    await controller.loadTranslations();
    Localization.load(
      controller.locale,
      translations: controller.translations,
      fallbackTranslations: controller.fallbackTranslations,
    );
  }

  /// Add to Cart
  static String get addToCart => _localization.tr('addToCart');

  /// Email
  static String get email => _localization.tr('email');

  /// Incorrect PIN
  static String get incorrectPin => _localization.tr('incorrectPin');

  /// Verification code not sent
  static String get codeNotSent => _localization.tr('codeNotSent');

  /// Resend Code
  static String get resendCode => _localization.tr('resendCode');

  /// Try Again
  static String get tryAgain => _localization.tr('tryAgain');

  /// Internal Server Error
  static String get internalServerError => _localization.tr('internalServerError');

  /// Server Error
  static String get serverError => _localization.tr('serverError');

  /// Something went wrong
  static String get somethingWentWrong => _localization.tr('somethingWentWrong');

  /// No internet connection
  static String get noInternetConnection => _localization.tr('noInternetConnection');

  /// Please try again later
  static String get tryAgainLater => _localization.tr('tryAgainLater');

  /// This field is required
  static String get thisFieldRequired => _localization.tr('thisFieldRequired');

  /// Please enter a valid email
  static String get validEmail => _localization.tr('validEmail');

  /// Password must be at least {min} characters
  static String get passwordMinLength => _localization.tr('passwordMinLength');

  /// Fields do not match
  static String get mustMatch => _localization.tr('mustMatch');

  /// Please enter a valid phone number
  static String get enterValidPhone => _localization.tr('enterValidPhone');

  /// Close
  static String get close => _localization.tr('close');

  /// Save
  static String get save => _localization.tr('save');

  /// Search
  static String get search => _localization.tr('search');

  /// No Image
  static String get noImage => _localization.tr('noImage');

  /// Upload Image Here
  static String get uploadImageHere => _localization.tr('uploadImageHere');

  /// Select Image Source
  static String get selectSource => _localization.tr('selectSource');

  /// Camera
  static String get camera => _localization.tr('camera');

  /// Gallery
  static String get gallery => _localization.tr('gallery');

  /// Files
  static String get files => _localization.tr('files');

  /// File Size Is Too Large
  static String get fileTooLarge => _localization.tr('fileTooLarge');

  /// Invalid File Type
  static String get invalidFileType => _localization.tr('invalidFileType');

  /// Confirm Upload
  static String get confirmUpload => _localization.tr('confirmUpload');

  /// Are You Sure You Want To Upload This File
  static String get areYouSureYouWantToUploadThisFile => _localization.tr('areYouSureYouWantToUploadThisFile');

  /// Cancel
  static String get cancel => _localization.tr('cancel');

  /// Confirm
  static String get confirm => _localization.tr('confirm');

  /// No Data Found
  static String get noDataFound => _localization.tr('noDataFound');

  /// No Results Found
  static String get noResultsFound => _localization.tr('noResultsFound');

  /// Phone Number Is Invalid
  static String get phoneNumberIsInvalid => _localization.tr('phoneNumberIsInvalid');

  /// Phone Number Is Required
  static String get phoneNumberIsRequired => _localization.tr('phoneNumberIsRequired');

  /// Phone Number
  static String get phoneNumber => _localization.tr('phoneNumber');

  /// Skip
  static String get skip => _localization.tr('skip');

  /// Copied to clipboard
  static String get copiedToClipboard => _localization.tr('copiedToClipboard');

  /// Leave Page?
  static String get leavePage => _localization.tr('leavePage');

  /// Are you sure you want to leave this page? Any unsaved changes will be lost.
  static String get areYouSureYouWantToLeave => _localization.tr('areYouSureYouWantToLeave');

  /// Yes, Leave
  static String get yesLeave => _localization.tr('yesLeave');

  /// Back to Login
  static String get backToLoginButton => _localization.tr('backToLoginButton');

  /// Forgot Password?
  static String get forgotPasswordTitle => _localization.tr('forgotPasswordTitle');

  /// User Name
  static String get userName => _localization.tr('userName');

  /// User Name must be at least 3 characters
  static String get userNameMinLength => _localization.tr('userNameMinLength');
}
