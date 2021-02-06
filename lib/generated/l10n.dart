// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `CrossFit Kabod`
  String get appName {
    return Intl.message(
      'CrossFit Kabod',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Time to Workout, let's Sign in`
  String get welcomeSubtitleText {
    return Intl.message(
      'Time to Workout, let\'s Sign in',
      name: 'welcomeSubtitleText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordButtonText {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get loginPageTitleText {
    return Intl.message(
      'Welcome!',
      name: 'loginPageTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password\n\n`
  String get resetPasswordTitleText {
    return Intl.message(
      'Reset Password\n\n',
      name: 'resetPasswordTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address. You will receive a link to create a new password via email`
  String get resetPasswordSubtitleText {
    return Intl.message(
      'Please enter your email address. You will receive a link to create a new password via email',
      name: 'resetPasswordSubtitleText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailFieldlabel {
    return Intl.message(
      'Email',
      name: 'emailFieldlabel',
      desc: '',
      args: [],
    );
  }

  /// `SEND`
  String get sendPasswordButtonText {
    return Intl.message(
      'SEND',
      name: 'sendPasswordButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get emailValidationError {
    return Intl.message(
      'Please enter a valid email',
      name: 'emailValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgainErrorText {
    return Intl.message(
      'Try again',
      name: 'tryAgainErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get successValidatorText {
    return Intl.message(
      'Success!',
      name: 'successValidatorText',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a new reset link to your email`
  String get successMessageText {
    return Intl.message(
      'We have sent a new reset link to your email',
      name: 'successMessageText',
      desc: '',
      args: [],
    );
  }

  /// `Continue to sign in`
  String get continuoToSignInText {
    return Intl.message(
      'Continue to sign in',
      name: 'continuoToSignInText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get passwordValidationError {
    return Intl.message(
      'Please enter password',
      name: 'passwordValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get confirmPasswordValidationEmptyError {
    return Intl.message(
      'Please confirm password',
      name: 'confirmPasswordValidationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirmPasswordValidationMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'confirmPasswordValidationMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordFieldLabel {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logoutButtonText {
    return Intl.message(
      'Log out',
      name: 'logoutButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePageTitle {
    return Intl.message(
      'Profile',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameFieldLabel {
    return Intl.message(
      'Name',
      name: 'nameFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneFieldLabel {
    return Intl.message(
      'Phone number',
      name: 'phoneFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressFieldLabel {
    return Intl.message(
      'Address',
      name: 'addressFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Coach`
  String get coachTitleText {
    return Intl.message(
      'Coach',
      name: 'coachTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Athlete`
  String get athleteTitleText {
    return Intl.message(
      'Athlete',
      name: 'athleteTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButtonLabel {
    return Intl.message(
      'Save',
      name: 'saveButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get pickFromGalleryButtonLabel {
    return Intl.message(
      'Gallery',
      name: 'pickFromGalleryButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInformationLabel {
    return Intl.message(
      'Personal information',
      name: 'personalInformationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get phoneInformationText {
    return Intl.message(
      'Please enter your phone number',
      name: 'phoneInformationText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get addressInformationText {
    return Intl.message(
      'Please enter your address',
      name: 'addressInformationText',
      desc: '',
      args: [],
    );
  }

  /// `Joined date`
  String get joinedDateLabel {
    return Intl.message(
      'Joined date',
      name: 'joinedDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get pickFromCameraButtonLabel {
    return Intl.message(
      'Take Photo',
      name: 'pickFromCameraButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickImageDialogTitle {
    return Intl.message(
      'Pick Image',
      name: 'pickImageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get introFinishButtonLabel {
    return Intl.message(
      'Get Started',
      name: 'introFinishButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add a new workout`
  String get addNewWODTitleText {
    return Intl.message(
      'Add a new workout',
      name: 'addNewWODTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleFieldText {
    return Intl.message(
      'Title',
      name: 'titleFieldText',
      desc: '',
      args: [],
    );
  }

  /// `Add a title`
  String get titleHintLabel {
    return Intl.message(
      'Add a title',
      name: 'titleHintLabel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionNewWODTitleText {
    return Intl.message(
      'Description',
      name: 'descriptionNewWODTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Add details`
  String get detailsHintLabel {
    return Intl.message(
      'Add details',
      name: 'detailsHintLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateLabelText {
    return Intl.message(
      'Date',
      name: 'dateLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Add date`
  String get dateHintLabel {
    return Intl.message(
      'Add date',
      name: 'dateHintLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}