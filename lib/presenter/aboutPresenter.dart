import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/view/view.dart';
import 'package:lista_de_tarefa/constants.dart' as constants;

class AboutPresenter implements IAboutPresenter{
  
  IAboutPage view;
  
  @override
  void setView(IAboutPage view) {
    this.view = view;
  }

  @override
  void sendFeedBack() {
    this.view.sendEmail(constants.EMAIL_DEV);
  }

  @override
  void share() {
    this.view.shareApp(constants.ANDROID_APP_LINK);
  }

  @override
  void shop() {
    this.view.openShop();
  }

}