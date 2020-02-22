class IPageList{

  void onClickFloatingButton(){}
  void onClickDelete(int index) {}
  void showSnackBarUndo(String title){}
  void showSnackBarInfo(String title){}
  void onChangedCheckButton(bool value, int index){}
  void onClickIconButtonSearch(){}
  void onRefresh(){}
  void updateList(List<Map> notes){}
  void onAbout(){}
  void showAboutPage(){}
  
}

class IPageNewNote{
  void onDropDownItemSelected(String newValue) {}
  void showSnackBarMessage(String message) {}
  void cleanField(){}
  void onCadastro(){}
}

class INoteEdit{
  void onDropDownItemSelected(String newValue) {}
   void showSnackBarMessage(String message) {}
   void cleanField() {}
   void onClickUpdate(){}
  void onClickDelete(){}
  void backPage() {}
  void setField(){}
}

class IAboutPage{
  
  void onFeedBack(){}
  void onShare(){}
  void onShop(){}

  void openShop(){}
  void sendEmail(String mail){}
  void shareApp(String text){}

}