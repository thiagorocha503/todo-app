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

  /// `Just now`
  String get justNow {
    return Intl.message(
      'Just now',
      name: 'justNow',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `No tasks`
  String get noTodo {
    return Intl.message(
      'No tasks',
      name: 'noTodo',
      desc: '',
      args: [],
    );
  }

  /// `Created {n}`
  String createdAt(Object n) {
    return Intl.message(
      'Created $n',
      name: 'createdAt',
      desc: '',
      args: [n],
    );
  }

  /// `Completed {n}`
  String completedAt(Object n) {
    return Intl.message(
      'Completed $n',
      name: 'completedAt',
      desc: '',
      args: [n],
    );
  }

  /// `Rate us on the Play Store`
  String get rate {
    return Intl.message(
      'Rate us on the Play Store',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Share with your friend`
  String get shareWithYourFriends {
    return Intl.message(
      'Share with your friend',
      name: 'shareWithYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Send feedBack`
  String get feedback {
    return Intl.message(
      'Send feedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
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

  /// `Add note`
  String get addDescription {
    return Intl.message(
      'Add note',
      name: 'addDescription',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Add task`
  String get addTodo {
    return Intl.message(
      'Add task',
      name: 'addTodo',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
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

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Complete ({n})`
  String complete(Object n) {
    return Intl.message(
      'Complete ($n)',
      name: 'complete',
      desc: '',
      args: [n],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Delete task?`
  String get deleteTaskAlertTitle {
    return Intl.message(
      'Delete task?',
      name: 'deleteTaskAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will delete '{task}' permanently. You cannot undo this action`
  String deleteTaskAlertBody(Object task) {
    return Intl.message(
      'This will delete \'$task\' permanently. You cannot undo this action',
      name: 'deleteTaskAlertBody',
      desc: '',
      args: [task],
    );
  }

  /// `Delete task`
  String get deleteTaskTooltip {
    return Intl.message(
      'Delete task',
      name: 'deleteTaskTooltip',
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

  /// `Delete list?`
  String get deleteListAlertTitle {
    return Intl.message(
      'Delete list?',
      name: 'deleteListAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will delete "{list}" permanently and all its tasks. You cannot undo this action`
  String deleteListAlertBody(Object list) {
    return Intl.message(
      'This will delete "$list" permanently and all its tasks. You cannot undo this action',
      name: 'deleteListAlertBody',
      desc: '',
      args: [list],
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

  /// `Fill out this field`
  String get fillOutThisFiled {
    return Intl.message(
      'Fill out this field',
      name: 'fillOutThisFiled',
      desc: '',
      args: [],
    );
  }

  /// `Add subtask`
  String get addSubtask {
    return Intl.message(
      'Add subtask',
      name: 'addSubtask',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `{n} selected`
  String nSelected(Object n) {
    return Intl.message(
      '$n selected',
      name: 'nSelected',
      desc: '',
      args: [n],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message(
      'Select all',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Seselect all`
  String get deselectAll {
    return Intl.message(
      'Seselect all',
      name: 'deselectAll',
      desc: '',
      args: [],
    );
  }

  /// `New list`
  String get addList {
    return Intl.message(
      'New list',
      name: 'addList',
      desc: '',
      args: [],
    );
  }

  /// `Edit list`
  String get editList {
    return Intl.message(
      'Edit list',
      name: 'editList',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Lists`
  String get lists {
    return Intl.message(
      'Lists',
      name: 'lists',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get inboxLabel {
    return Intl.message(
      'Inbox',
      name: 'inboxLabel',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get inboxTitle {
    return Intl.message(
      'Inbox',
      name: 'inboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Browse`
  String get browse {
    return Intl.message(
      'Browse',
      name: 'browse',
      desc: '',
      args: [],
    );
  }

  /// `Recent searches`
  String get recentSearches {
    return Intl.message(
      'Recent searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `No result`
  String get noResult {
    return Intl.message(
      'No result',
      name: 'noResult',
      desc: '',
      args: [],
    );
  }

  /// `All tasks`
  String get allTodo {
    return Intl.message(
      'All tasks',
      name: 'allTodo',
      desc: '',
      args: [],
    );
  }

  /// `Show complete`
  String get showComplete {
    return Intl.message(
      'Show complete',
      name: 'showComplete',
      desc: '',
      args: [],
    );
  }

  /// `Hide complete`
  String get hidComplete {
    return Intl.message(
      'Hide complete',
      name: 'hidComplete',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'AR'),
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
