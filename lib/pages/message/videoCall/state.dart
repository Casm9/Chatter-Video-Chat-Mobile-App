import 'package:get/get.dart';

class VideoCallState{

  RxBool isJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableSpeaker = true.obs;
  RxString callTime = "00.00".obs;
  RxString callStatus = "not connected".obs;
  RxString callTimeNum = "not connected".obs;

  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;
  var call_role = "audience".obs;
  var channelId = "".obs;

  RxBool isReadyPreview = false.obs;
  RxBool isShowAvatar = true.obs; //if user did not join show avatar.
  RxBool switchCamera = true.obs; //change camera front or back.
  RxInt onRemoteUID = 0.obs; //remembers remote id of the user from Agora.



}