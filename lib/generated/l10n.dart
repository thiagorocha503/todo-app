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

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Task`
  String get todo {
    return Intl.message(
      'Task',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get todos {
    return Intl.message(
      'Tasks',
      name: 'todos',
      desc: '',
      args: [],
    );
  }

  /// `just now`
  String get justNow {
    return Intl.message(
      'just now',
      name: 'justNow',
      desc: '',
      args: [],
    );
  }

  /// `today`
  String get today {
    return Intl.message(
      'today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `yesterday`
  String get yesterday {
    return Intl.message(
      'yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `tomorrow`
  String get tomorrow {
    return Intl.message(
      'tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `no tasks`
  String get noTodo {
    return Intl.message(
      'no tasks',
      name: 'noTodo',
      desc: '',
      args: [],
    );
  }

  /// `created`
  String get createdAt {
    return Intl.message(
      'created',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get completedAt {
    return Intl.message(
      'completed',
      name: 'completedAt',
      desc: '',
      args: [],
    );
  }

  /// `rate us on the Play Store`
  String get rate {
    return Intl.message(
      'rate us on the Play Store',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `share with your friend`
  String get shareWithYourFriends {
    return Intl.message(
      'share with your friend',
      name: 'shareWithYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `send feedBack`
  String get feedback {
    return Intl.message(
      'send feedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settings {
    return Intl.message(
      'settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Add due date`
  String get addDueDate {
    return Intl.message(
      'Add due date',
      name: 'addDueDate',
      desc: '',
      args: [],
    );
  }

  /// `add note`
  String get addNote {
    return Intl.message(
      'add note',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `note`
  String get note {
    return Intl.message(
      'note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `done`
  String get done {
    return Intl.message(
      'done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `add task`
  String get addTodo {
    return Intl.message(
      'add task',
      name: 'addTodo',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `saved`
  String get saved {
    return Intl.message(
      'saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get language {
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message(
      'all',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `done`
  String get complete {
    return Intl.message(
      'done',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `active`
  String get active {
    return Intl.message(
      'active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `filter`
  String get filter {
    return Intl.message(
      'filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `delete task`
  String get deleteAlertTitle {
    return Intl.message(
      'delete task',
      name: 'deleteAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want to delete this task?`
  String get deleteAlertContent {
    return Intl.message(
      'are you sure you want to delete this task?',
      name: 'deleteAlertContent',
      desc: '',
      args: [],
    );
  }

  /// `delete task`
  String get delete {
    return Intl.message(
      'delete task',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterName {
    return Intl.message(
      'Enter name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `fill out this field`
  String get fillOutName {
    return Intl.message(
      'fill out this field',
      name: 'fillOutName',
      desc: '',
      args: [],
    );
  }

  /// `add subtask`
  String get addSubtask {
    return Intl.message(
      'add subtask',
      name: 'addSubtask',
      desc: '',
      args: [],
    );
  }

  /// `theme`
  String get theme {
    return Intl.message(
      'theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `light`
  String get light {
    return Intl.message(
      'light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `dark`
  String get dark {
    return Intl.message(
      'dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `system`
  String get system {
    return Intl.message(
      'system',
      name: 'system',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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
