
import 'package:chatter/pages/message/videoCall/index.dart';
import 'package:get/get.dart';

class VideoCallBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());

  }

}