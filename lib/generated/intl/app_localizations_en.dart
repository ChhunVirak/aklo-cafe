import 'app_localizations.dart';

/// The translations for English (`en`).
class LangsEn extends Langs {
  LangsEn([String locale = 'en']) : super(locale);

  @override
  String get languages => 'Languages';

  @override
  String get languagesDes => 'Choose Preference Languages';

  @override
  String get email => 'Email';

  @override
  String get emailValidateMessage => 'Email is required.';

  @override
  String get password => 'Password';

  @override
  String get passwordValidateMessage => 'Password is required.';

  @override
  String get login => 'Login';

  @override
  String get inventory => 'Inventory';

  @override
  String get allCoffeeTitle => 'All Drinks';

  @override
  String get addDrink => 'Add New Drink';

  @override
  String get addCategory => 'Add New Category';

  @override
  String get category => 'All Categories';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get setting => 'Setting';

  @override
  String get signout => 'Sign Out';
}
