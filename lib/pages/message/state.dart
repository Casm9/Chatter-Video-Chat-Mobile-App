import 'package:chatter/common/entities/entities.dart';
import 'package:get/get.dart';

class MessageState{
  var head_detail = UserItem().obs;
  RxBool tapStatus = true.obs;
  RxList<Message> msgList = <Message>[].obs;
  RxList<CallMessage> callList = <CallMessage>[].obs;
}