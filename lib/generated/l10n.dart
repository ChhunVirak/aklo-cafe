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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Choose Preference Languages`
  String get languagesDes {
    return Intl.message(
      'Choose Preference Languages',
      name: 'languagesDes',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email is required.`
  String get emailValidateMessage {
    return Intl.message(
      'Email is required.',
      name: 'emailValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password is required.`
  String get passwordValidateMessage {
    return Intl.message(
      'Password is required.',
      name: 'passwordValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Histories`
  String get histories {
    return Intl.message(
      'Histories',
      name: 'histories',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get inventory {
    return Intl.message(
      'Inventory',
      name: 'inventory',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `All Drinks`
  String get allCoffeeTitle {
    return Intl.message(
      'All Drinks',
      name: 'allCoffeeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Drink`
  String get addDrink {
    return Intl.message(
      'Add Drink',
      name: 'addDrink',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get category {
    return Intl.message(
      'All Categories',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signout {
    return Intl.message(
      'Sign Out',
      name: 'signout',
      desc: '',
      args: [],
    );
  }

  /// `Scan to E-Menu`
  String get scan {
    return Intl.message(
      'Scan to E-Menu',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Drink Name`
  String get drinkName {
    return Intl.message(
      'Drink Name',
      name: 'drinkName',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get categoryName {
    return Intl.message(
      'Category',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Unit Price`
  String get unitPrice {
    return Intl.message(
      'Unit Price',
      name: 'unitPrice',
      desc: '',
      args: [],
    );
  }

  /// `Amounts`
  String get amount {
    return Intl.message(
      'Amounts',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Field drink name can't be empty.`
  String get drinkNameValidateMessage {
    return Intl.message(
      'Field drink name can\'t be empty.',
      name: 'drinkNameValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Field drink category can't be empty.`
  String get drinkCategoryValidateMessage {
    return Intl.message(
      'Field drink category can\'t be empty.',
      name: 'drinkCategoryValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Field drink unit price can't be empty.`
  String get drinkUnitPriceValidateMessage {
    return Intl.message(
      'Field drink unit price can\'t be empty.',
      name: 'drinkUnitPriceValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Drink price can't be 0$.`
  String get drinkUnitPriceValidateMessagesmallthanzero {
    return Intl.message(
      'Drink price can\'t be 0\$.',
      name: 'drinkUnitPriceValidateMessagesmallthanzero',
      desc: '',
      args: [],
    );
  }

  /// `Drink price can't be more than 20$.`
  String get drinkUnitPriceValidateMessagemax {
    return Intl.message(
      'Drink price can\'t be more than 20\$.',
      name: 'drinkUnitPriceValidateMessagemax',
      desc: '',
      args: [],
    );
  }

  /// `Field drink amount can't be empty.`
  String get drinkTotalAmountValidateMessage {
    return Intl.message(
      'Field drink amount can\'t be empty.',
      name: 'drinkTotalAmountValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Field category name can't be empty.`
  String get categoryNameAmountValidateMessage {
    return Intl.message(
      'Field category name can\'t be empty.',
      name: 'categoryNameAmountValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Category English Name`
  String get category_name_en {
    return Intl.message(
      'Category English Name',
      name: 'category_name_en',
      desc: '',
      args: [],
    );
  }

  /// `Category Khmer Name`
  String get category_name_kh {
    return Intl.message(
      'Category Khmer Name',
      name: 'category_name_kh',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get category_desc {
    return Intl.message(
      'Description',
      name: 'category_desc',
      desc: '',
      args: [],
    );
  }

  /// `Field Category English Name can't be empty.`
  String get category_name_en_ValidateMessage {
    return Intl.message(
      'Field Category English Name can\'t be empty.',
      name: 'category_name_en_ValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Field Category Khmer Name can't be empty.`
  String get category_name_kh_ValidateMessage {
    return Intl.message(
      'Field Category Khmer Name can\'t be empty.',
      name: 'category_name_kh_ValidateMessage',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Delete Successfully`
  String get delete_success {
    return Intl.message(
      'Delete Successfully',
      name: 'delete_success',
      desc: '',
      args: [],
    );
  }

  /// `Make Order`
  String get make_order {
    return Intl.message(
      'Make Order',
      name: 'make_order',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get no_data {
    return Intl.message(
      'No Data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `No Image`
  String get noImage {
    return Intl.message(
      'No Image',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unAvailable {
    return Intl.message(
      'Unavailable',
      name: 'unAvailable',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newOrder {
    return Intl.message(
      'New',
      name: 'newOrder',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this Drink?`
  String get warning_delete {
    return Intl.message(
      'Do you want to delete this Drink?',
      name: 'warning_delete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please add drink`
  String get add_drink_message {
    return Intl.message(
      'Please add drink',
      name: 'add_drink_message',
      desc: '',
      args: [],
    );
  }

  /// `a drink is required to make order`
  String get add_drink_message_des {
    return Intl.message(
      'a drink is required to make order',
      name: 'add_drink_message_des',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get check_out {
    return Intl.message(
      'Check Out',
      name: 'check_out',
      desc: '',
      args: [],
    );
  }

  /// `Today Total Order`
  String get today_Total_Order {
    return Intl.message(
      'Today Total Order',
      name: 'today_Total_Order',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `New Order`
  String get new_order {
    return Intl.message(
      'New Order',
      name: 'new_order',
      desc: '',
      args: [],
    );
  }

  /// `Sugar Level`
  String get sugar {
    return Intl.message(
      'Sugar Level',
      name: 'sugar',
      desc: '',
      args: [],
    );
  }

  /// `Drink Done, please go to get your Drinks!`
  String get drink_done {
    return Intl.message(
      'Drink Done, please go to get your Drinks!',
      name: 'drink_done',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get add_profile {
    return Intl.message(
      'Add Member',
      name: 'add_profile',
      desc: '',
      args: [],
    );
  }

  /// `Fail`
  String get fail {
    return Intl.message(
      'Fail',
      name: 'fail',
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
      Locale.fromSubtags(languageCode: 'kk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
