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
  String get inventory => 'ស្តុក';

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
}
