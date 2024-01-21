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

  static String m0(n) => "complete (${n})";

  static String m1(n) => "completed ${n}";

  static String m2(n) => "created ${n}";

  static String m3(list) =>
      "this will delete \"${list}\" permanently and all its tasks. You cannot undo this action";

  static String m4(task) =>
      "this will delete \'${task}\' permanently. You cannot undo this action";

  static String m5(n) => "${n} selected";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription": MessageLookupByLibrary.simpleMessage("add note"),
        "addDueDate": MessageLookupByLibrary.simpleMessage("Add due date"),
        "addList": MessageLookupByLibrary.simpleMessage("New list"),
        "addSubtask": MessageLookupByLibrary.simpleMessage("add subtask"),
        "addTodo": MessageLookupByLibrary.simpleMessage("add task"),
        "allTodo": MessageLookupByLibrary.simpleMessage("all tasks"),
        "browse": MessageLookupByLibrary.simpleMessage("browse"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "clear": MessageLookupByLibrary.simpleMessage("clear"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("dark"),
        "delete": MessageLookupByLibrary.simpleMessage("delete"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("delete list?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("delete task?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("delete task"),
        "description": MessageLookupByLibrary.simpleMessage("description"),
        "deselectAll": MessageLookupByLibrary.simpleMessage("deselect all"),
        "editList": MessageLookupByLibrary.simpleMessage("Edit list"),
        "enterName": MessageLookupByLibrary.simpleMessage("Enter name"),
        "error": MessageLookupByLibrary.simpleMessage("error"),
        "feedback": MessageLookupByLibrary.simpleMessage("send feedBack"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("fill out this field"),
        "hidComplete": MessageLookupByLibrary.simpleMessage("hide complete"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("inbox"),
        "inboxTitle": MessageLookupByLibrary.simpleMessage("inbox"),
        "justNow": MessageLookupByLibrary.simpleMessage("just now"),
        "language": MessageLookupByLibrary.simpleMessage("language"),
        "light": MessageLookupByLibrary.simpleMessage("light"),
        "lists": MessageLookupByLibrary.simpleMessage("lists"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("name"),
        "noResult": MessageLookupByLibrary.simpleMessage("no result"),
        "noTodo": MessageLookupByLibrary.simpleMessage("no tasks"),
        "rate":
            MessageLookupByLibrary.simpleMessage("rate us on the Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("recent searches"),
        "rename": MessageLookupByLibrary.simpleMessage("rename"),
        "save": MessageLookupByLibrary.simpleMessage("save"),
        "saved": MessageLookupByLibrary.simpleMessage("saved"),
        "search": MessageLookupByLibrary.simpleMessage("search"),
        "selectAll": MessageLookupByLibrary.simpleMessage("select all"),
        "settings": MessageLookupByLibrary.simpleMessage("settings"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("share with your friend"),
        "showComplete": MessageLookupByLibrary.simpleMessage("show complete"),
        "system": MessageLookupByLibrary.simpleMessage("system"),
        "theme": MessageLookupByLibrary.simpleMessage("theme"),
        "today": MessageLookupByLibrary.simpleMessage("today"),
        "todo": MessageLookupByLibrary.simpleMessage("Task"),
        "todos": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("tomorrow"),
        "yesterday": MessageLookupByLibrary.simpleMessage("yesterday")
      };
}
