class IPageList {
  void onClickFloatingButton() {}
  void onClickDelete(int index) {}
  void showSnackBarInfo(String title) {}
  void onChangedCheckButton(bool value, int index) {}
  void onClickIconButtonSearch() {}
  void onRefresh() {}
  void updateList(List<Map> notes) {}
  void onAbout() {}
  void showAboutPage() {}
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
  void backPage() {}
  void setField() {}
}

class IAboutPage {
  void onFeedBack() {}
  void onShare() {}
  void onShop() {}

  void openShop() {}
  void sendEmail(String mail) {}
  void shareApp(String text) {}
}
