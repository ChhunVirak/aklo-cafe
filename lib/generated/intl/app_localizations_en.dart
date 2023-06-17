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
  String get orders => 'Orders';

  @override
  String get histories => 'Histories';

  @override
  String get inventory => 'Inventory';

  @override
  String get users => 'Users';

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

  @override
  String get scan => 'Scan to E-Menu';

  @override
  String get drinkName => 'Drink Name';

  @override
  String get categoryName => 'Category';

  @override
  String get unitPrice => 'Unit Price';

  @override
  String get amount => 'Amounts';

  @override
  String get add => 'Add';

  @override
  String get update => 'Update';

  @override
  String get drinkNameValidateMessage => 'Field drink name can\'t be empty.';

  @override
  String get drinkCategoryValidateMessage => 'Field drink category can\'t be empty.';

  @override
  String get drinkUnitPriceValidateMessage => 'Field drink unit price can\'t be empty.';

  @override
  String get drinkTotalAmountValidateMessage => 'Field drink amount can\'t be empty.';

  @override
  String get categoryNameAmountValidateMessage => 'Field category name can\'t be empty.';

  @override
  String get category_name_en => 'Category English Name';

  @override
  String get category_name_kh => 'Category Khmer Name';

  @override
  String get category_desc => 'Description';

  @override
  String get category_name_en_ValidateMessage => 'Field Category English Name can\'t be empty.';

  @override
  String get category_name_kh_ValidateMessage => 'Field Category Khmer Name can\'t be empty.';

  @override
  String get all => 'All';

  @override
  String get success => 'Success';

  @override
  String get delete_success => 'Delete Successfully';

  @override
  String get make_order => 'Make Order';
}
