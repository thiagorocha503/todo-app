// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static String m0(n) => "concluída (${n})";

  static String m1(n) => "concluído ${n}";

  static String m2(n) => "criado ${n}";

  static String m3(list) =>
      "isso irá excluir \"${list}\" permanentemente e todas as suas tarefas. Você não pode desfazer esta ação";

  static String m4(task) =>
      "isso irá excluir \"${task}\" permanentemente. Você não pode desfazer esta ação";

  static String m5(n) => "${n} selecionado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription":
            MessageLookupByLibrary.simpleMessage("adicioar descrição"),
        "addDueDate": MessageLookupByLibrary.simpleMessage("adicionar prazo"),
        "addList": MessageLookupByLibrary.simpleMessage("Nova lista"),
        "addSubtask":
            MessageLookupByLibrary.simpleMessage("adiconar subtarefa"),
        "addTodo": MessageLookupByLibrary.simpleMessage("adicionar tarefa"),
        "allTodo": MessageLookupByLibrary.simpleMessage("todas as tarefas"),
        "browse": MessageLookupByLibrary.simpleMessage("navegar"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancelar"),
        "clear": MessageLookupByLibrary.simpleMessage("limpar"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("escuro"),
        "delete": MessageLookupByLibrary.simpleMessage("excluir"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("excluir lista?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("excluir tarefa?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("excluir tarefa"),
        "description": MessageLookupByLibrary.simpleMessage("descrição"),
        "deselectAll": MessageLookupByLibrary.simpleMessage("desmacar tudo"),
        "editList": MessageLookupByLibrary.simpleMessage("Editar lista"),
        "enterName": MessageLookupByLibrary.simpleMessage("Digite o nome"),
        "error": MessageLookupByLibrary.simpleMessage("erro"),
        "feedback": MessageLookupByLibrary.simpleMessage("enviar feedback"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("preencha este campo"),
        "hidComplete":
            MessageLookupByLibrary.simpleMessage("ocultar concluída"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("entrada"),
        "inboxTitle": MessageLookupByLibrary.simpleMessage("caixa de entrada"),
        "justNow": MessageLookupByLibrary.simpleMessage("agora pouco"),
        "language": MessageLookupByLibrary.simpleMessage("idioma"),
        "light": MessageLookupByLibrary.simpleMessage("claro"),
        "lists": MessageLookupByLibrary.simpleMessage("listas"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("nome"),
        "noResult": MessageLookupByLibrary.simpleMessage("nenhum resultado"),
        "noTodo": MessageLookupByLibrary.simpleMessage("nenhuma tarefa"),
        "rate": MessageLookupByLibrary.simpleMessage("avalie na Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("pesquisas recente"),
        "rename": MessageLookupByLibrary.simpleMessage("renomear"),
        "save": MessageLookupByLibrary.simpleMessage("salvar"),
        "saved": MessageLookupByLibrary.simpleMessage("salvo"),
        "search": MessageLookupByLibrary.simpleMessage("pesquisar"),
        "selectAll": MessageLookupByLibrary.simpleMessage("selecionar tudo"),
        "settings": MessageLookupByLibrary.simpleMessage("configurações"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("compartilhe com seus amigos"),
        "showComplete":
            MessageLookupByLibrary.simpleMessage("mostrar concluída"),
        "system": MessageLookupByLibrary.simpleMessage("sistema"),
        "theme": MessageLookupByLibrary.simpleMessage("tema"),
        "today": MessageLookupByLibrary.simpleMessage("hoje"),
        "todo": MessageLookupByLibrary.simpleMessage("tarefa"),
        "todos": MessageLookupByLibrary.simpleMessage("tarefas"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("amanhã"),
        "yesterday": MessageLookupByLibrary.simpleMessage("ontem")
      };
}
