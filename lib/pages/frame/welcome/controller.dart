import 'package:chatter/pages/frame/welcome/state.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  WelcomeController();
  final title = "Chatter .";
  final state = WelcomeState();

  @override
  void onReady(){
    super.onReady();
  }

}