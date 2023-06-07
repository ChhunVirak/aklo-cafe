import 'app_localizations.dart';

/// The translations for Kazakh (`kk`).
class LangsKk extends Langs {
  LangsKk([String locale = 'kk']) : super(locale);

  @override
  String get languages => 'ភាសា';

  @override
  String get languagesDes => 'រើសភាសា';

  @override
  String get email => 'អ៊ីម៉ែល';

  @override
  String get emailValidateMessage => 'សូមបញ្ចូលអ៊ីម៉ែល';

  @override
  String get password => 'លេខសំងាត់';

  @override
  String get passwordValidateMessage => 'សូមបញ្ចូលលេខសំងាត់';

  @override
  String get login => 'ចូល';

  @override
  String get orders => 'ការកម្ម៉ង់ទាំងអស់';

  @override
  String get histories => 'ប្រវត្តិ';

  @override
  String get inventory => 'ស្តុក';

  @override
  String get users => 'អ្នកប្រើប្រាស់';

  @override
  String get allCoffeeTitle => 'ភេសជ្ជៈទាំងអស់';

  @override
  String get addDrink => 'បន្ថែមភេសជ្ជៈ';

  @override
  String get addCategory => 'បន្ថែមស្តុក';

  @override
  String get category => 'ស្តុកទាំងអស់';

  @override
  String get dashboard => 'ផ្ទាំងគ្រប់គ្រង';

  @override
  String get setting => 'ការកំណត់';

  @override
  String get signout => 'ចាកចេញ';

  @override
  String get scan => 'ស្គែនទៅកាន់ មីនុយអេឡិចត្រូនិច';

  @override
  String get drinkNameValidateMessage => 'ឈ្មោះភេសជ្ជៈមិនអាចទទេបានទេ';

  @override
  String get drinkCategoryValidateMessage => 'ប្រភេទភេសជ្ជៈមិនអាចទទេបានទេ';

  @override
  String get drinkUnitPriceValidateMessage => 'តម្លៃឯកតាភេសជ្ជៈមិនអាចទទេបានទេ';

  @override
  String get drinkTotalAmountValidateMessage => 'បរិមាណភេសជ្ជៈមិនអាចទទេបានទេ';

  @override
  String get categoryNameAmountValidateMessage => 'ឈ្មោះប្រភេទមិនអាចទទេបានទេ។';
}
