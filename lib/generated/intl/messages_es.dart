// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(n) => "concluyó (${n})";

  static String m1(n) => "concluyó ${n}";

  static String m2(n) => "creado ${n}";

  static String m3(list) =>
      "esto eliminará \"${list}\" permanentemente y todas sus tareas. No puedes deshacer esta acción";

  static String m4(task) =>
      "esto eliminará \"${task}\" permanentemente. No puedes deshacer esta acción";

  static String m5(n) => "${n} seleccionado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription":
            MessageLookupByLibrary.simpleMessage("añadir descripción"),
        "addDueDate": MessageLookupByLibrary.simpleMessage(
            "Agregar fecha de vencimiento"),
        "addList": MessageLookupByLibrary.simpleMessage("Nueva lista"),
        "addSubtask": MessageLookupByLibrary.simpleMessage("agregar subtarea"),
        "addTodo": MessageLookupByLibrary.simpleMessage("añadir tarea"),
        "allTodo": MessageLookupByLibrary.simpleMessage("todas las tareas"),
        "browse": MessageLookupByLibrary.simpleMessage("navegar"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancelar"),
        "clear": MessageLookupByLibrary.simpleMessage("borrar"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("oscuro"),
        "delete": MessageLookupByLibrary.simpleMessage("eliminar"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("¿eliminar list?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("¿eliminar tarea?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("eliminar tarea"),
        "description": MessageLookupByLibrary.simpleMessage("descripción"),
        "deselectAll":
            MessageLookupByLibrary.simpleMessage("deseleccionar todo"),
        "editList": MessageLookupByLibrary.simpleMessage("Editar lista"),
        "enterName": MessageLookupByLibrary.simpleMessage("Ingrese el nombre"),
        "error": MessageLookupByLibrary.simpleMessage("error"),
        "feedback": MessageLookupByLibrary.simpleMessage("enviar comentarios"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("rellene este campo"),
        "hidComplete": MessageLookupByLibrary.simpleMessage("ocultar concluyó"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("entrada"),
        "inboxTitle":
            MessageLookupByLibrary.simpleMessage("bandeja de entrada"),
        "justNow": MessageLookupByLibrary.simpleMessage("justo ahora"),
        "language": MessageLookupByLibrary.simpleMessage("idioma"),
        "light": MessageLookupByLibrary.simpleMessage("claro"),
        "lists": MessageLookupByLibrary.simpleMessage("listas"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("nombre"),
        "noResult": MessageLookupByLibrary.simpleMessage("sin resultado"),
        "noTodo": MessageLookupByLibrary.simpleMessage("sin tareas"),
        "rate":
            MessageLookupByLibrary.simpleMessage("califícanos en Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("búsquedas recientes"),
        "rename": MessageLookupByLibrary.simpleMessage("renombrar"),
        "save": MessageLookupByLibrary.simpleMessage("guardar"),
        "saved": MessageLookupByLibrary.simpleMessage("guardado"),
        "search": MessageLookupByLibrary.simpleMessage("buscar"),
        "selectAll": MessageLookupByLibrary.simpleMessage("seleccionar todo"),
        "settings": MessageLookupByLibrary.simpleMessage("configuración"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("compartir con tu amigo"),
        "showComplete":
            MessageLookupByLibrary.simpleMessage("mostrar concluyó"),
        "system": MessageLookupByLibrary.simpleMessage("sistema"),
        "theme": MessageLookupByLibrary.simpleMessage("tema"),
        "today": MessageLookupByLibrary.simpleMessage("hoy"),
        "todo": MessageLookupByLibrary.simpleMessage("tarea"),
        "todos": MessageLookupByLibrary.simpleMessage("tareas"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("mañana"),
        "yesterday": MessageLookupByLibrary.simpleMessage("ayer")
      };
}
