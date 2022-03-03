/// Application configuration including themes or constants

import 'package:flutter/material.dart';

/// `lightTheme`
///
/// use this to customize your normal theme
final ThemeData lightTheme = ThemeData();

/// `darkTheme`
///
/// use this to customize your dark mode theme
final ThemeData darkTheme = ThemeData.dark();

/// `languageKey`
///
/// use this key into shared preference to save or get lang cache
const String localeKey = "lang";

/// `themeKey`
///
/// use this key into shared preference to save or get theme cache
const String themeKey = "theme";

/// `placeholder`
///
/// place holder represent the local asset image as place holder
const String placeholder = "assets/images/loading.png";

/// `fallbackLocale`
///
const fallbackLocale = Locale('en', 'US');

/// `startLocale`
///
///
const startLocale = Locale('en', 'US');

/// `supportedLocales`
///
///
const supportedLocales = [fallbackLocale, Locale('km', 'KH')];

/// `translationsPath`
///
///
const translationsPath = "assets/translations";

/// `restorationScopeId`
///
///
const restorationScopeId = "app";

/// `appTitle`
/// 
/// 
const appTitle = "Myst Example";
