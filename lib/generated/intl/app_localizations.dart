import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';

/// Callers can lookup localized strings with an instance of Langs
/// returned by `Langs.of(context)`.
///
/// Applications need to include `Langs.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Langs.localizationsDelegates,
///   supportedLocales: Langs.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Langs.supportedLocales
/// property.
abstract class Langs {
  Langs(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Langs? of(BuildContext context) {
    return Localizations.of<Langs>(context, Langs);
  }

  static const LocalizationsDelegate<Langs> delegate = _LangsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk')
  ];

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @languagesDes.
  ///
  /// In en, this message translates to:
  /// **'Choose Preference Languages'**
  String get languagesDes;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailValidateMessage;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordValidateMessage;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @histories.
  ///
  /// In en, this message translates to:
  /// **'Histories'**
  String get histories;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @allCoffeeTitle.
  ///
  /// In en, this message translates to:
  /// **'All Drinks'**
  String get allCoffeeTitle;

  /// No description provided for @addDrink.
  ///
  /// In en, this message translates to:
  /// **'Add Drink'**
  String get addDrink;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get category;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @signout.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signout;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan to E-Menu'**
  String get scan;

  /// No description provided for @drinkName.
  ///
  /// In en, this message translates to:
  /// **'Drink Name'**
  String get drinkName;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryName;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amounts'**
  String get amount;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @drinkNameValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field drink name can\'t be empty.'**
  String get drinkNameValidateMessage;

  /// No description provided for @drinkCategoryValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field drink category can\'t be empty.'**
  String get drinkCategoryValidateMessage;

  /// No description provided for @drinkUnitPriceValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field drink unit price can\'t be empty.'**
  String get drinkUnitPriceValidateMessage;

  /// No description provided for @drinkTotalAmountValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field drink amount can\'t be empty.'**
  String get drinkTotalAmountValidateMessage;

  /// No description provided for @categoryNameAmountValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field category name can\'t be empty.'**
  String get categoryNameAmountValidateMessage;

  /// No description provided for @category_name_en.
  ///
  /// In en, this message translates to:
  /// **'Category English Name'**
  String get category_name_en;

  /// No description provided for @category_name_kh.
  ///
  /// In en, this message translates to:
  /// **'Category Khmer Name'**
  String get category_name_kh;

  /// No description provided for @category_desc.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get category_desc;

  /// No description provided for @category_name_en_ValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field Category English Name can\'t be empty.'**
  String get category_name_en_ValidateMessage;

  /// No description provided for @category_name_kh_ValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Field Category Khmer Name can\'t be empty.'**
  String get category_name_kh_ValidateMessage;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @delete_success.
  ///
  /// In en, this message translates to:
  /// **'Delete Successfully'**
  String get delete_success;

  /// No description provided for @make_order.
  ///
  /// In en, this message translates to:
  /// **'Make Order'**
  String get make_order;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get no_data;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'No Image'**
  String get noImage;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unAvailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unAvailable;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newOrder;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;
}

class _LangsDelegate extends LocalizationsDelegate<Langs> {
  const _LangsDelegate();

  @override
  Future<Langs> load(Locale locale) {
    return SynchronousFuture<Langs>(lookupLangs(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kk'].contains(locale.languageCode);

  @override
  bool shouldReload(_LangsDelegate old) => false;
}

Langs lookupLangs(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return LangsEn();
    case 'kk': return LangsKk();
  }

  throw FlutterError(
    'Langs.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
