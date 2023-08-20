import 'package:chatter/pages/message/voicecall/index.dart';
import 'package:get/get.dart';

class VoiceCallBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());

  }

}