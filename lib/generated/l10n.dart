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

  /// `created {n}`
  String createdAt(Object n) {
    return Intl.message(
      'created $n',
      name: 'createdAt',
      desc: '',
      args: [n],
    );
  }

  /// `completed {n}`
  String completedAt(Object n) {
    return Intl.message(
      'completed $n',
      name: 'completedAt',
      desc: '',
      args: [n],
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
  String get addDescription {
    return Intl.message(
      'add note',
      name: 'addDescription',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
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

  /// `complete ({n})`
  String complete(Object n) {
    return Intl.message(
      'complete ($n)',
      name: 'complete',
      desc: '',
      args: [n],
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

  /// `delete task?`
  String get deleteTaskAlertTitle {
    return Intl.message(
      'delete task?',
      name: 'deleteTaskAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `this will delete '{task}' permanently. You cannot undo this action`
  String deleteTaskAlertBody(Object task) {
    return Intl.message(
      'this will delete \'$task\' permanently. You cannot undo this action',
      name: 'deleteTaskAlertBody',
      desc: '',
      args: [task],
    );
  }

  /// `delete task`
  String get deleteTaskTooltip {
    return Intl.message(
      'delete task',
      name: 'deleteTaskTooltip',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `delete list?`
  String get deleteListAlertTitle {
    return Intl.message(
      'delete list?',
      name: 'deleteListAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `this will delete "{list}" permanently and all its tasks. You cannot undo this action`
  String deleteListAlertBody(Object list) {
    return Intl.message(
      'this will delete "$list" permanently and all its tasks. You cannot undo this action',
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

  /// `fill out this field`
  String get fillOutThisFiled {
    return Intl.message(
      'fill out this field',
      name: 'fillOutThisFiled',
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

  /// `{n} selected`
  String nSelected(Object n) {
    return Intl.message(
      '$n selected',
      name: 'nSelected',
      desc: '',
      args: [n],
    );
  }

  /// `select all`
  String get selectAll {
    return Intl.message(
      'select all',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `deselect all`
  String get deselectAll {
    return Intl.message(
      'deselect all',
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

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `rename`
  String get rename {
    return Intl.message(
      'rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `lists`
  String get lists {
    return Intl.message(
      'lists',
      name: 'lists',
      desc: '',
      args: [],
    );
  }

  /// `inbox`
  String get inboxLabel {
    return Intl.message(
      'inbox',
      name: 'inboxLabel',
      desc: '',
      args: [],
    );
  }

  /// `inbox`
  String get inboxTitle {
    return Intl.message(
      'inbox',
      name: 'inboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `browse`
  String get browse {
    return Intl.message(
      'browse',
      name: 'browse',
      desc: '',
      args: [],
    );
  }

  /// `recent searches`
  String get recentSearches {
    return Intl.message(
      'recent searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `clear`
  String get clear {
    return Intl.message(
      'clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `no result`
  String get noResult {
    return Intl.message(
      'no result',
      name: 'noResult',
      desc: '',
      args: [],
    );
  }

  /// `all tasks`
  String get allTodo {
    return Intl.message(
      'all tasks',
      name: 'allTodo',
      desc: '',
      args: [],
    );
  }

  /// `show complete`
  String get showComplete {
    return Intl.message(
      'show complete',
      name: 'showComplete',
      desc: '',
      args: [],
    );
  }

  /// `hide complete`
  String get hidComplete {
    return Intl.message(
      'hide complete',
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
