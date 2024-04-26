import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mertaliveonurcan/product/utility/locales.dart';

///Project localization class for operation and configuration
final class ProductLocalization extends EasyLocalization {
  ///Project localization class for operation and configuration
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _path,
          startLocale: Locales.en.locale,
          useOnlyLangCode: true,
        );

  ///Project supported locales
  static final List<Locale> _supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  ///Project localization path
  static const String _path = 'assets/translations';

  ///Project localization update method
  static Future<void> updateLang(BuildContext context, Locales locale) =>
      context.setLocale(locale.locale);
}
