import 'package:chatter/pages/contact/index.dart';
import 'package:get/get.dart';

class ContactBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());

  }

}