import 'package:chatter/common/apis/apis.dart';
import 'package:chatter/common/entities/base.dart';
import 'package:chatter/common/routes/names.dart';
import 'package:chatter/common/utils/FirebaseMessagingHandler.dart';
import 'package:chatter/pages/message/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  MessageController();
  final state = MessageState();

  void goProfile() async{
    await Get.toNamed(AppRoutes.Profile);
  }

  @override
  void onReady(){
    super.onReady();
    firebaseMessageSetup();
}
  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("...my device token is $fcmToken");
    if(fcmToken!=null){
     BindFcmTokenRequestEntity bindFcmTokenRequestEntity = BindFcmTokenRequestEntity();
     bindFcmTokenRequestEntity.fcmtoken = fcmToken;
     await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }


}