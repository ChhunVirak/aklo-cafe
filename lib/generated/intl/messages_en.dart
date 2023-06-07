// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("Add New Category"),
        "addDrink": MessageLookupByLibrary.simpleMessage("Add New Drink"),
        "allCoffeeTitle": MessageLookupByLibrary.simpleMessage("All Drinks"),
        "category": MessageLookupByLibrary.simpleMessage("All Categories"),
        "categoryNameAmountValidateMessage":
            MessageLookupByLibrary.simpleMessage(
                "Field category name can\'t be empty."),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "drinkCategoryValidateMessage": MessageLookupByLibrary.simpleMessage(
            "Field drink category can\'t be empty."),
        "drinkNameValidateMessage": MessageLookupByLibrary.simpleMessage(
            "Field drink name can\'t be empty."),
        "drinkTotalAmountValidateMessage": MessageLookupByLibrary.simpleMessage(
            "Field drink amount can\'t be empty."),
        "drinkUnitPriceValidateMessage": MessageLookupByLibrary.simpleMessage(
            "Field drink unit price can\'t be empty."),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailValidateMessage":
            MessageLookupByLibrary.simpleMessage("Email is required."),
        "histories": MessageLookupByLibrary.simpleMessage("Histories"),
        "inventory": MessageLookupByLibrary.simpleMessage("Inventory"),
        "languages": MessageLookupByLibrary.simpleMessage("Languages"),
        "languagesDes":
            MessageLookupByLibrary.simpleMessage("Choose Preference Languages"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordValidateMessage":
            MessageLookupByLibrary.simpleMessage("Password is required."),
        "scan": MessageLookupByLibrary.simpleMessage("Scan to E-Menu"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "signout": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "users": MessageLookupByLibrary.simpleMessage("Users")
      };
}
