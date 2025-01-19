// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es_AR locale. All the
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
  String get localeName => 'es_AR';

  static String m0(n) => "Concluyó (${n})";

  static String m1(n) => "Concluyó ${n}";

  static String m2(n) => "Creado ${n}";

  static String m3(list) =>
      "Esto eliminará \"${list}\" permanentemente y todas sus tareas. No puedes deshacer esta acción";

  static String m4(task) =>
      "Esto eliminará \"${task}\" permanentemente. No puedes deshacer esta acción";

  static String m5(n) => "${n} seleccionado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Añadir descripción"),
        "addDueDate": MessageLookupByLibrary.simpleMessage(
            "Agregar fecha de vencimiento"),
        "addList": MessageLookupByLibrary.simpleMessage("Nueva lista"),
        "addSubtask": MessageLookupByLibrary.simpleMessage("Agregar subtarea"),
        "addTodo": MessageLookupByLibrary.simpleMessage("Añadir tarea"),
        "allTodo": MessageLookupByLibrary.simpleMessage("Todas las tareas"),
        "browse": MessageLookupByLibrary.simpleMessage("Navegar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "clear": MessageLookupByLibrary.simpleMessage("Borrar"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("¿Eliminar lista?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("¿Eliminar tarea?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("Eliminar tarea"),
        "description": MessageLookupByLibrary.simpleMessage("Descripción"),
        "deselectAll":
            MessageLookupByLibrary.simpleMessage("Deseleccionar todo"),
        "editList": MessageLookupByLibrary.simpleMessage("Editar lista"),
        "enterName": MessageLookupByLibrary.simpleMessage("Ingrese el nombre"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "feedback": MessageLookupByLibrary.simpleMessage("Enviar comentarios"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("Rellene este campo"),
        "hidComplete": MessageLookupByLibrary.simpleMessage("Ocultar concluyó"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("Entrada"),
        "inboxTitle":
            MessageLookupByLibrary.simpleMessage("Bandeja de entrada"),
        "justNow": MessageLookupByLibrary.simpleMessage("Justo ahora"),
        "language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "light": MessageLookupByLibrary.simpleMessage("Claro"),
        "lists": MessageLookupByLibrary.simpleMessage("Listas"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("Nombre"),
        "noResult": MessageLookupByLibrary.simpleMessage("Sin resultado"),
        "noTodo": MessageLookupByLibrary.simpleMessage("Sin tareas"),
        "rate":
            MessageLookupByLibrary.simpleMessage("Califícanos en Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("Búsquedas recientes"),
        "rename": MessageLookupByLibrary.simpleMessage("Renombrar"),
        "save": MessageLookupByLibrary.simpleMessage("Guardar"),
        "saved": MessageLookupByLibrary.simpleMessage("Guardado"),
        "search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Seleccionar todo"),
        "settings": MessageLookupByLibrary.simpleMessage("Configuración"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("Compartir con tu amigo"),
        "showComplete":
            MessageLookupByLibrary.simpleMessage("Mostrar concluyó"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "today": MessageLookupByLibrary.simpleMessage("Hoy"),
        "todo": MessageLookupByLibrary.simpleMessage("Tarea"),
        "todos": MessageLookupByLibrary.simpleMessage("Tareas"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Mañana"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Ayer")
      };
}
