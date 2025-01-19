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

  static String m0(n) => "Concluída (${n})";

  static String m1(n) => "Concluído ${n}";

  static String m2(n) => "Criado ${n}";

  static String m3(list) =>
      "Isso irá excluir \"${list}\" permanentemente e todas as suas tarefas. Você não pode desfazer esta ação";

  static String m4(task) =>
      "Isso irá excluir \"${task}\" permanentemente. Você não pode desfazer esta ação";

  static String m5(n) => "${n} selecionado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Adicioar descrição"),
        "addDueDate": MessageLookupByLibrary.simpleMessage("Adicionar prazo"),
        "addList": MessageLookupByLibrary.simpleMessage("Nova lista"),
        "addSubtask":
            MessageLookupByLibrary.simpleMessage("Adiconar subtarefa"),
        "addTodo": MessageLookupByLibrary.simpleMessage("Adicionar tarefa"),
        "allTodo": MessageLookupByLibrary.simpleMessage("Todas as tarefas"),
        "browse": MessageLookupByLibrary.simpleMessage("Navegar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "clear": MessageLookupByLibrary.simpleMessage("Limpar"),
        "complete": m0,
        "completedAt": m1,
        "createdAt": m2,
        "dark": MessageLookupByLibrary.simpleMessage("Escuro"),
        "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
        "deleteListAlertBody": m3,
        "deleteListAlertTitle":
            MessageLookupByLibrary.simpleMessage("Excluir lista?"),
        "deleteTaskAlertBody": m4,
        "deleteTaskAlertTitle":
            MessageLookupByLibrary.simpleMessage("Excluir tarefa?"),
        "deleteTaskTooltip":
            MessageLookupByLibrary.simpleMessage("Excluir tarefa"),
        "description": MessageLookupByLibrary.simpleMessage("Descrição"),
        "deselectAll": MessageLookupByLibrary.simpleMessage("Desmacar tudo"),
        "editList": MessageLookupByLibrary.simpleMessage("Editar lista"),
        "enterName": MessageLookupByLibrary.simpleMessage("Digite o nome"),
        "error": MessageLookupByLibrary.simpleMessage("Erro"),
        "feedback": MessageLookupByLibrary.simpleMessage("Enviar feedback"),
        "fillOutThisFiled":
            MessageLookupByLibrary.simpleMessage("Preencha este campo"),
        "hidComplete":
            MessageLookupByLibrary.simpleMessage("Ocultar concluída"),
        "inboxLabel": MessageLookupByLibrary.simpleMessage("Entrada"),
        "inboxTitle": MessageLookupByLibrary.simpleMessage("Caixa de entrada"),
        "justNow": MessageLookupByLibrary.simpleMessage("Agora pouco"),
        "language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "light": MessageLookupByLibrary.simpleMessage("Claro"),
        "lists": MessageLookupByLibrary.simpleMessage("Listas"),
        "nSelected": m5,
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "noResult": MessageLookupByLibrary.simpleMessage("Nenhum resultado"),
        "noTodo": MessageLookupByLibrary.simpleMessage("Nenhuma tarefa"),
        "rate": MessageLookupByLibrary.simpleMessage("Avalie na Play Store"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("Pesquisas recente"),
        "rename": MessageLookupByLibrary.simpleMessage("Renomear"),
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "saved": MessageLookupByLibrary.simpleMessage("Salvo"),
        "search": MessageLookupByLibrary.simpleMessage("Pesquisar"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Selecionar tudo"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
        "shareWithYourFriends":
            MessageLookupByLibrary.simpleMessage("Compartilhe com seus amigos"),
        "showComplete":
            MessageLookupByLibrary.simpleMessage("Mostrar concluída"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "today": MessageLookupByLibrary.simpleMessage("Hoje"),
        "todo": MessageLookupByLibrary.simpleMessage("Tarefa"),
        "todos": MessageLookupByLibrary.simpleMessage("Tarefas"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Amanhã"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Ontem")
      };
}
