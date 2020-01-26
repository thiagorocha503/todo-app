class IPageList{

  void onClickFloatingButton(){}
  void onClickDelete(int index) {}
  void showSnackBarUndo(String title){}
  void showSnackBarInfo(String title){}
  void onChangedCheckButton(bool value, int index){}
  void onClickIconButtonSearch(){}
  void updateList(List<Map> notes){}
  
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
  void getNote(){}
}