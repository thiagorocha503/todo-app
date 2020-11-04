class IHomePage {
  void onClickFloatingButton() {}
  void onClickDelete(int index) {}
  void showSnackBarInfo(String title) {}
  void onChangedCheckButton(int id, bool value) {}
  void onClickIconButtonSearch() {}
  void showAboutPage() {}
  void onRefresh() {}
}

class IPageNewTodo {
  void onDropDownItemSelected(String newValue) {}
  void showSnackBarMessage(String message) {}
  void cleanField() {}
  void onCadastro() {}
}

class ITodoEdit {
  void onDropDownItemSelected(String newValue) {}
  void showSnackBarMessage(String message) {}
  void onClickUpdate() {}
  void onClickDelete() {}
  void backPage({showSuccessDelete}) {}
  void setField() {}
}

class IAboutPage {
  void onContact() {}
  void onShare() {}
  void onStore() {}
}
