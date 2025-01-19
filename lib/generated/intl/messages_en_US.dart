// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(n) => "Complete (${n})";

  static String m1(n) => "Completed ${n}";

  static String m2(n) => "Created ${n}";

  static String m3(list) =>
      "This will delete \"${list}\" permanently and all its tasks. You cannot undo this action";

  static String m4(task) =>
      "This will delete \'${task}\' permanently. You cannot undo this action";

  static String m5(n) => "${n} selected";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription": MessageLookupByLibrary.simpleMessage("Add note"),
        "addDueDate": MessageLookupByLibrary.simpleMessage("Add due date"),
        "addList": MessageLookupByLibrary.simpleMessage("New list"),
        "addSubtask": MessageLookupByLibrary.simpleMessage("Add subtask"),
        "addTodo": MessageLookupByLibrary.simpleMessage("Add task"),
        "allTodo": MessageLookupByLibrary.simpleMessage("All tasks"),
        "browse": MessageLookupByLibrary.simpleMessage("Browse"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("Delete list?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("Delete task?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("Delete task"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "deselectAll": MessageLookupByLibrary.simpleMessage("Seselect all"),
        "editList": MessageLookupByLibrary.simpleMessage("Edit list"),
        "enterName": MessageLookupByLibrary.simpleMessage("Enter name"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "feedback": MessageLookupByLibrary.simpleMessage("Send feedBack"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("Fill out this field"),
        "hidComplete": MessageLookupByLibrary.simpleMessage("Hide complete"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("Inbox"),
        "inboxTitle": MessageLookupByLibrary.simpleMessage("Inbox"),
        "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "lists": MessageLookupByLibrary.simpleMessage("Lists"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noResult": MessageLookupByLibrary.simpleMessage("No result"),
        "noTodo": MessageLookupByLibrary.simpleMessage("No tasks"),
        "rate":
            MessageLookupByLibrary.simpleMessage("Rate us on the Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("Recent searches"),
        "rename": MessageLookupByLibrary.simpleMessage("Rename"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("Share with your friend"),
        "showComplete": MessageLookupByLibrary.simpleMessage("Show complete"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "todo": MessageLookupByLibrary.simpleMessage("Task"),
        "todos": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday")
      };
}
